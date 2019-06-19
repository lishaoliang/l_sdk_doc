#!/usr/bin/python3
#-*-coding:utf-8-*-
"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/14
//
/// @file    hello.py
/// @brief   使用NSPP私有协议, 拉取设备所有请求
/// @version 0.1
/// @author  李绍良
///////////////////////////////////////////////////////////////////////////
"""
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()

import re
import target as tg


# 初始化, 登录
l_sdk.init()
l_sdk.login(ip = tg.ip, port = tg.port, username = tg.username, passwd = tg.passwd)



def filter(key):
    # 排除登录等命令
    ex = ['support', 'login', 'logout', 'stream', 'stream_pic', 'default_stream', 'default_stream_pic']
    if key in ex:
        return False

    # 排除 set_*, open_*, close_* 等命令
    if re.match(r'set_*|open_*|close_*', key) :
        return False 

    return True


try:
    # 获取所有支持的协议命令
    cmds = l_sdk.request({'cmd':'support'})['support']['cmds']
    #print('request support cmds:', cmds)

    keys = cmds.split(',')
    keys.sort()

    # 请求一般协议
    for k in keys:
        k.strip()
        if filter(k):
            print('request cmd', l_sdk.request({'cmd':k, k:{'chnn':0}}))
        else:
            print('not', k)

    # 请求流相关
    print('request cmd', l_sdk.request({'cmd':'stream', 'stream':{'chnn':0, 'idx':0}}))
    print('request cmd', l_sdk.request({'cmd':'stream', 'stream':{'chnn':0, 'idx':1}}))
    print('request cmd', l_sdk.request({'cmd':'stream_pic', 'stream_pic':{'chnn':0, 'idx':64}}))
    print('request cmd', l_sdk.request({'cmd':'stream_pic', 'stream_pic':{'chnn':0, 'idx':65}}))

except Exception as e:
    print(e)


# 登出,退出
l_sdk.logout()
l_sdk.quit()
