#-*-coding:utf-8-*-
"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/17
//
/// @file    sdkc.py
/// @brief   sdk class接口
/// @version 1.0.11
///////////////////////////////////////////////////////////////////////////
"""

import re
import time
import l_sdk


class sdkc:
    def __init__(self, *, cfg={}, req=None, ip='192.168.1.247', port=80, username='admin', passwd='123456'):
        try:
            self.m_ip = req['ip']
            self.m_port = req['port']
            self.m_username = req['login']['username']
            self.m_passwd = req['login']['passwd']
        except Exception as e:
            self.m_ip = ip
            self.m_port = port
            self.m_username = username
            self.m_passwd = passwd

        self.m_login_id = 0
        self.streams = []

        l_sdk.init(cfg = cfg)
        l_sdk.discover_open()


    def __del__(self):
        self.logout()
        l_sdk.discover_close()
        l_sdk.quit()


    def __enter__(self):
        return self


    def __exit__(self, exc_type, exc_value, exc_tb):
        if exc_tb is None:
            return False
        else:
            return False


    def get_devs(self, *, tm=3.0):
        """
        /// @brief 打开搜索之后, 获取当前网络中的设备
        /// @param [in] tm  等待时间3.0秒
        /// @return {},[] 设备列表
        """
        l_sdk.discover_run(True)
        time.sleep(tm)
        devs = l_sdk.discover_get_devs()
        l_sdk.discover_run(False)
        return devs


    def login(self):
        """
        /// @brief  登入
        /// @return 无
        """
        self.logout()
        self.m_login_id = l_sdk.login(ip = self.m_ip, port = self.m_port, username = self.m_username, passwd = self.m_passwd)
        #print('login', self.m_login_id)


    def logout(self):
        """
        /// @brief  登出
        /// @return 无
        """
        if 0 != self.m_login_id :
            #print('logout', self.m_login_id)
            l_sdk.logout(id = self.m_login_id)
            self.m_login_id = 0


    def request(self, req):
        """
        /// @brief 向设备发起请求
        /// @param [in] req 字典形式的json数据
        /// @return 字典
        /// @note 耗时视具体请求, 最多几秒
        ///   具体的请求,回复数据格式参见 协议文档
        ///   https://github.com/lishaoliang/l_sdk_doc, 媒体-控制子协议
        """
        #print('request', req)
        return l_sdk.request(req, id = self.m_login_id)

    
    def support(self):
        """
        /// @brief 获取设备所支持的协议命令
        /// @return 字典
        """
        try:
            cmds = self.request({'cmd':'support'})['support']['cmds']
            keys = cmds.split(',')
            keys.sort()
            return keys
        except Exception as e:
            return []


    def get(self, k='', *, chnn=0, idx=0):
        """
        /// @brief 向设备发起获取请求
        /// @param [in] k     关键字字符串
        /// @param [in] chnn  通道号
        /// @param [in] idx   流序号
        /// @return 字典
        /// @note 耗时视具体请求, 最多几秒
        ///   具体的请求,回复数据格式参见 协议文档
        ///   https://github.com/lishaoliang/l_sdk_doc, 媒体-控制子协议
        """
        try:
            s = self.request({'cmd':k, k:{'chnn':chnn,'idx':idx}})[k]

            if 0 == s['code'] :
                s.pop('code')
                return s
            else:
                return {}

        except Exception as e:
            return {}


    def get_default(self, k='', *, chnn=0, idx=0):
        """
        /// @brief 向设备发起获取默认请求
        /// @param [in] k     关键字字符串; 实际请求: 'default_' + k
        /// @param [in] chnn  通道号
        /// @param [in] idx   流序号
        /// @return 字典
        /// @note 耗时视具体请求, 最多几秒
        ///   具体的请求,回复数据格式参见 协议文档
        ///   https://github.com/lishaoliang/l_sdk_doc, 媒体-控制子协议
        """
        dkey = 'default_' + k
        try:
            s = self.request({'cmd':dkey, dkey:{'chnn':chnn,'idx':idx}})[dkey]

            if 0 == s['code'] :
                s.pop('code')
                return s
            else:
                return {}

        except Exception as e:
            return {}


    def set(self, k='', v={}, *, chnn=0, idx=0):
        """
        /// @brief 向设备发起设置请求
        /// @param [in] k     关键字字符串; 实际请求: 'set_' + k
        /// @param [in] chnn  通道号
        /// @param [in] idx   流序号
        /// @return int 0.成功; -1.异常; 大于0.错误码
        /// @note 耗时视具体请求, 最多几秒
        ///   具体的请求,回复数据格式参见 协议文档
        ///   https://github.com/lishaoliang/l_sdk_doc, 媒体-控制子协议
        """
        skey = 'set_' + k
        v['chnn'] = chnn
        v['idx'] = idx

        try:
            s = self.request({'cmd':skey, skey:v})[skey]
            return s['code']

        except Exception as e:
            return -1

    
    def open_stream(self, dec_id=10000, *, chnn=0, idx=0, md_id=0,
                    dec_cfg={'pix_fmt':'BGR888'}):
        """
        /// @brief 开启媒体流
        /// @param [in] dec_id     编码器ID(非0. 不可重复)
        /// @param [in] chnn       通道号
        /// @param [in] idx        流序号
        /// @param [in] md_id      媒体id
        /// @param [in] dec_cfg    解码器配置
        ///     解码之后像素格式: 默认YUV420P_SEPARATE
        ///     dec_cfg.pix_fmt = ['ARGB8888', 'RGB888', 'YUV420P_SEPARATE', 'ABGR8888', 'BGR888'
        ///                        'RGBA8888', 'BGRA8888']
        /// @return int 0.成功; -1.异常; 大于0.错误码
        /// @note 耗时视具体请求, 最多几秒
        /// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
        """
        req = {
            'cmd' : 'open_stream',
            'open_stream' : {
                'chnn' : chnn,
                'idx' : idx,
                'md_id' : md_id
            }
        }
        
        code = 0    
        try:
            s = self.request(req)['open_stream']
            code = s['code']

        except Exception as e:
            code = -1

        if 0 == code :
            if 0 < dec_id :
                if 0 == l_sdk.dec_open(dec_id = dec_id, cfg = dec_cfg) :
                    l_sdk.dec_bind(dec_id, self.m_login_id, chnn = chnn, idx = idx, md_id = md_id)
                else:
                    dec_id = 0
            else:
                dec_id = 0

            key = '%d-%d-%d-%d'%(chnn, idx, md_id, dec_id)
            self.streams.append(key)
            #print(self.stream)

        return code

    def close_stream(self, *, chnn=0, idx=0, md_id=0):
        """
        /// @brief 关闭媒体流
        /// @param [in] chnn       通道号
        /// @param [in] idx        流序号
        /// @param [in] md_id      媒体id
        /// @return int 0.成功; -1.异常; 大于0.错误码
        /// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
        """
        req = {
            'cmd' : 'close_stream',
            'close_stream' : {
                'chnn' : chnn,
                'idx' : idx,
                'md_id' : md_id
            }
        }

        try:
            s = self.request(req)['close_stream']
            return s['code']

        except Exception as e:
            return -1


    def get_stream(self, *, chnn=0, idx=0, md_id=0):
        """
        /// @brief 获取(视频)媒体流
        /// @param [in] chnn               通道号
        /// @param [in] idx                流序号
        /// @param [in] md_id              媒体id
        /// @return 异常 或 numpy.array[]  与numpy模块兼容的3或4维图像数组
        /// @note 获得数组后, 可以使用通用python库来操作图像数据
        ///   比如: opencv的各种滤波处理
        /// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
        """
        dec_id = 0
        key = '%d-%d-%d-*'%(chnn, idx, md_id)

        for stream in self.streams:
            if re.match(key, stream):
                dec_id = int(stream.split('-')[3])
                break

        return l_sdk.dec_get_md_data(dec_id)
