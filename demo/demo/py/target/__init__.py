#-*-coding:utf-8-*-
"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/14
//
/// @file    target
/// @brief   目标设备信息
/// @version 0.1
/// @author  李绍良
///////////////////////////////////////////////////////////////////////////
"""
__version__ = '1.0.11'

__all__ = [
    'ip',
    'port',
    'path',
    'username',
    'passwd',
    'wifi_ssid',
    'wifi_passwd',
]

__author__ = 'lishaoliang'


ip          = '192.168.1.247'           # 设备IP
port        = 80                        # 设备端口
path        = '/luajson'                # 短连接请求路径
username    = 'admin'                   # 用户名
passwd      = '123456'                  # 密码
wifi_ssid   = 'HUAWEI-7NLNPF_5G'        # 相机处于STA模式下,待连接的目标wifi的ssid名称
wifi_passwd = 'qwertyuiop1234567890'    # 相机处于STA模式下,待连接的目标wifi的密码
