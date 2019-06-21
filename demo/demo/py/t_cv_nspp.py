#!/usr/bin/python3
#-*-coding:utf-8-*-

"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/19
//
/// @file    t_cv_nspp.py
/// @brief   NSPP私有协议获取视频流, opencv显示
///  每帧视频图像, 可以使用 opencv, numpy 等做中间处理
/// @version 0.1
/// @author  李绍良
/// @see https://github.com/lishaoliang/l_sdk_doc
///////////////////////////////////////////////////////////////////////////
"""
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()

import time
import target as tg
import cv2 as cv


# 流ID 0.主码流; 1.子码流
idx = 0


# 处理图像帧
def process(frame):
    """
    使用cv处理帧
    """
    #frame = cv.medianBlur(frame, 5)                # 测试中值滤波
    #frame = cv.bilateralFilter(frame, 5, 100, 3);  # 测试双边滤波
    return frame


with l_sdk.c(ip = tg.ip, 
            port = tg.port, 
            username = tg.username, 
            passwd = tg.passwd) as a:

    # 登录
    a.login()
    a.open_stream(idx = idx)


    # 创建窗口显示
    wndname = 'opencv nspp demo'
    cv.namedWindow(wndname, cv.WINDOW_NORMAL)
    cv.resizeWindow(wndname, 960, 540)


    # 循环显示每帧
    while True:
        try:
            frame = a.get_stream(idx = idx)
            frame = process(frame)
            cv.imshow(wndname, frame)
        except Exception as e:
            pass

        ch = cv.waitKey(1)
        if 27 == ch :
            break


    # 销毁所有cv窗口
    cv.destroyAllWindows()
