#!/usr/bin/python3
#-*-coding:utf-8-*-

"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/18
//
/// @file    t_get.py
/// @brief   测试获取命令协议
/// @version 0.1
/// @author  李绍良
/// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/sdk/l_sdk_discover.md
///////////////////////////////////////////////////////////////////////////
"""
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()

import re
import target as tg


def filter(key):
    # 排除登录等命令
    ex = ['support', 'login', 'logout', 'stream', 'stream_pic']
    if key in ex:
        return False

    # 排除 set_*, open_*, close_*, default_* 等命令
    if re.match(r'set_*|open_*|close_*|default_*', key) :
        return False 

    return True


with l_sdk.c(ip = tg.ip, 
            port = tg.port, 
            username = tg.username, 
            passwd = tg.passwd) as a:
    
    # 登录
    a.login()

    # 获取所有支持的cmd
    keys = a.support()
    print(keys)
    
    # 获取可以get,get_default的k
    for k in keys:
        if filter(k):
            print(k + ' :', a.get(k))
            print('default_' + k + ' :', a.get_default(k))

    # 视频流
    for i in range(0, 1):
        print('stream' + ' :', a.get('stream', idx=i))
        print('default_' + 'stream' + ' :', a.get_default('stream', idx=i))

    # 图片流
    for i in range(64, 65):
        print('stream_pic' + ' :', a.get('stream_pic', idx=i))
        print('default_' + 'stream_pic' + ' :', a.get_default('stream_pic', idx=i))
