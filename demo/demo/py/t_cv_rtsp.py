#!/usr/bin/python3
#-*-coding:utf-8-*-

"""
///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件, All Rights Reserved
//  Created: 2019/06/18
//
/// @file    t_cv_rtsp.py
/// @brief   使用opencv拉取rtsp流
/// @version 0.1
/// @author  李绍良
/// @see https://github.com/lishaoliang/l_sdk_doc/blob/master/sdk/l_sdk_discover.md
///////////////////////////////////////////////////////////////////////////
"""
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()

import cv2 as cv
import target as tg


# rtsp://admin:123456@192.168.1.247:80/chnn=0&id=0
url = "rtsp://" + tg.username + ":" + tg.passwd + "@" + tg.ip + ":" + str(tg.port) + "/chnn=0&id=0"
print(url)


# 打开rtsp网络流
cap = cv.VideoCapture(url)
print('isOpened :', cap.isOpened())


# 处理图像帧
def process(frame):
    """
    使用cv处理帧
    """
    #frame = cv.medianBlur(frame, 5) # 测试中值滤波
    return frame


# 创建窗口显示
wndname = 'opencv rtsp demo'
cv.namedWindow(wndname, cv.WINDOW_NORMAL)
cv.resizeWindow(wndname, 960, 540)


# 循环显示每帧
while cap.isOpened():
    ret, frame = cap.read()
    if not ret:
        break

    frame = process(frame)

    cv.imshow(wndname, frame)
    ch = cv.waitKey(1)

    if 27 == ch :
        break


# 销毁所有cv窗口
cv.destroyAllWindows()
