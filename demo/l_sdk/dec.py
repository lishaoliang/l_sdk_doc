#-*-coding:utf-8-*-
"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/19
//
/// @file    dec.py
/// @brief   视频流解码器
/// @version 0.1
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
"""

import json             # json.dumps json.loads 
import l_sdk_py         # 从l_sdk_py.pyd文件加载接口


def dec_open(dec_id = 100, *, cfg = {}):
    """
    /// @brief 打开一个解码器
    /// @param [in] dec_id  解码器ID
    /// @param [in] cfg     字典形式的json配置数据
    /// @return int 错误码
    """
    config = ''
    try:
        config = json.dumps(cfg)
    except Exception as e:
        pass

    code = l_sdk_py.dec_open(dec_id, config)
    return code


def dec_close(dec_id = 100):
    """
    /// @brief 关闭解码器
    /// @param [in] dec_id  解码器ID
    /// @return int 错误码
    """
    code = l_sdk_py.dec_close(dec_id)
    return code


def dec_bind(dec_id = 100, login_id = 1000, *, chnn = 0, idx = 0, md_id = 0):
    """
    /// @brief 关闭解码器
    /// @param [in] dec_id      解码器ID
    /// @param [in] login_id    登录ID
    /// @param [in] chnn        通道号
    /// @param [in] idx         流序号
    /// @param [in] md_id       媒体自定义ID
    /// @return int 错误码
    """
    code = l_sdk_py.dec_bind(dec_id, login_id, chnn, idx, md_id)
    return code


def dec_unbind(dec_id = 100):
    """
    /// @brief 关闭解码器
    /// @param [in] dec_id      解码器ID
    /// @return int 错误码
    """
    code = l_sdk_py.dec_unbind(dec_id)
    return code


def dec_get_md_data(dec_id = 100):
    """
    /// @brief 获取数据
    /// @param [in] dec_id      解码器ID
    /// @return numpy.array
    """
    array = l_sdk_py.dec_get_md_data(dec_id)
    return array
