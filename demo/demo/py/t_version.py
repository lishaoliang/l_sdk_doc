#!/usr/bin/python3
#-*-coding:utf-8-*-

"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/17
//
/// @file    t_version.py
/// @brief   使用相关库版本信息
/// @version 0.1
/// @author  李绍良
///////////////////////////////////////////////////////////////////////////
"""

# l_sdk 版本
import l_sdk
l_sdk.append_path()

print("l_sdk", l_sdk.__version__)

# opencv 版本
import cv2 as cv
print("cv", cv.__version__)

# requests 版本
import requests
print("requests", requests.__version__)
