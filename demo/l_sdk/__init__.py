#-*-coding:utf-8-*-
"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件, All Rights Reserved
//  Created: 2018/12/22
//
/// @file    l_sdk
/// @brief   sdk接口; 目标支持PC,手机等内存,CPU资源充足的平台
///  各个函数参数具体细节参见: 私有协议文档, SDK文档
///  sdk接口设计原则: 1.兼容公司各种设备; 2.不得任意变更接口; 3.sdk版本本身兼容性; 4.精简接口
/// @version 0.2
/// @author  李绍良
/// @history 修改历史
///  2018/12/22 0.1 创建文件
///  2019/04/13 0.2 将网络搜索从主工程中剔除, 成为独立搜索摸索模块
///     搜索模块预留支持 nspp广播, onvif组播等第三方搜索
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
"""

# 当前目录加入查找
import os
import sys
PWD = os.getcwd()
if not PWD in sys.path :
    sys.path.append(PWD)

import json                 # json.dumps json.loads 
import l_sdk_py             # 从l_sdk_py.pyd文件加载接口

# 网络发现部分函数
from .discover import discover_open, discover_close, discover_run, discover_get_devs

# 解码器部分函数
from .dec import dec_open, dec_close, dec_bind, dec_unbind, dec_get_md_data

# 类封装
from .sdkc import sdkc as c

__version__ = '1.0.11'

__all__ = [
    'c',

    'append_path',
    'dump',

    'init',
    'quit',
    'login',
    'logout',
    'request',

    'discover_open',
    'discover_close',
    'discover_run',
    'discover_get_devs',
    'discover_request',

    'dec_open',
    'dec_close',
    'dec_bind',
    'dec_unbind',
    'dec_get_md_data',
]

__author__ = 'lishaoliang'


# 记录初始化次数
g_init_count = 0


# 记录上一次的登录ID
g_login_id = 0


def append_path():
    """
    /// @brief 添加部分目录到标准搜索目录
    ///  1.PWD + '/site-packages'   # 标准开源扩展库
    ///  2.PWD + '/demo/py'         # 示例py库
    ///  3.PWD + '/demo'            # 示例py库
    /// @return 无
    """
    packages = PWD + '/site-packages'
    if not packages in sys.path :
        sys.path.append(packages)

    demo_py = PWD + '/demo/py'
    if not demo_py in sys.path :
        sys.path.append(demo_py)

    demo = PWD + '/demo'
    if not demo_py in sys.path :
        sys.path.append(demo)


def dump():
    """
    /// @brief dump
    """
    print('***** l_sdk dump *****')



def init(*, cfg = {}):
    """
    /// @brief sdk初始化
    /// @param [in] cfg 字典形式的json配置数据
    /// @return 无
    /// @note 错误码参见SDK错误码
    """
    global g_init_count
    global g_login_id

    if 0 == g_init_count :
        g_login_id += 1
        config = ''
        try:
            config = json.dumps(cfg)
        except Exception as e:
            pass

        try:
            l_sdk_py.init(config)
        except Exception as e:
            pass
    else:
        g_init_count += 1



def quit():
    """
    /// @brief sdk退出
    /// @return 无
    """
    global g_init_count
    global g_login_id

    g_init_count -= 1

    if g_init_count <= 0 :
        l_sdk_py.quit()
        g_login_id = 0
        g_init_count = 0



def login(*, req=None, ip='192.168.1.247', port=80, username='admin', passwd='123456'):
    """
    /// @brief 登入到某个设备
    /// @param [in] req         字典形式的json数据
    /// @param [in] ip          目标IP[obj = None]
    /// @param [in] port        目标端口[obj = None]
    /// @param [in] username    用户名[obj = None]
    /// @param [in] passwd      密码[obj = None]
    /// @return int 登录ID[1000, 0x7FFF0000]
    /// @note 
    ///  例如: obj={"ip":"192.168.1.247","port":80,"login":{"username":"admin","passwd":"123456"}}
    """
    if None == req :
        req = {
            'ip' : ip,
            'port' : port,
            'login' : {
                'username' : username,
                'passwd' : passwd
            }
        }

    txt = ''
    try:
        txt = json.dumps(req)
    except Exception as e:
        pass

    #print('login param:', txt)
    id = l_sdk_py.login(txt)
    #print('login id:', id)

    global g_login_id
    g_login_id = id

    return id



def logout(*, id = 0):
    """
    /// @brief 登出某个设备
    /// @param [in] id  登录id
    /// @return 无
    """
    global g_login_id

    if None == id or 0 == id :
        id = g_login_id

    l_sdk_py.logout(id)
    g_login_id = 0
    return



def request(req, *, id = 0):
    """
    /// @brief 向设备发起请求
    /// @param [in] req 字典形式的json数据
    /// @param [in] id  登录ID
    /// @return 字典
    /// @note 耗时视具体请求, 最多几秒
    ///   具体的请求,回复数据格式参见 协议文档
    ///   https://github.com/lishaoliang/l_sdk_doc, 媒体-控制子协议
    """
    txt = ''
    try:
        txt = json.dumps(req)
    except Exception as e:
        pass

    if 0 == id :
        id = g_login_id
    
    #print('request:', req, id, g_login_id)
    res = l_sdk_py.request(id, txt)

    ret = {}
    try:
        ret = json.loads(res)
    except Exception as e:
        pass

    return ret
