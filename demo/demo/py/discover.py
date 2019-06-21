#!/usr/bin/python3
#-*-coding:utf-8-*-

"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/14
//
/// @file    t_discover.py
/// @brief   测试网络发现
/// @version 0.1
/// @author  李绍良
/// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/sdk/l_sdk_discover.md
///////////////////////////////////////////////////////////////////////////
"""
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()

import re
import time
#import target as tg


# 初始化, 打开网络发现, 打开搜索
l_sdk.init()
l_sdk.discover_open()
l_sdk.discover_run(True)


# 间隔N秒, 获取网络发现结果
for i in range(1, 10):
    time.sleep(1)
    print(l_sdk.discover_get_devs())


#devs = l_sdk.discover_get_devs()
#print(devs[0]['sn'], devs[0]['ip'], devs[0]['discover']['sw_ver'])


# 登出,关闭网络发现,关闭搜索
l_sdk.discover_run(False)
l_sdk.discover_close()
l_sdk.quit()
