///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/12/22
//
/// @file    l_sdk_discover.h
/// @brief   网络发现模块: 1.网络发现; 2.广播协议命令
/// @version 0.2
/// @author  李绍良
/// @history 修改历史
///  \n 2018/12/22 0.1 创建文件
///  \n 2019/04/13 0.2 函数签名修改为 *_discover_* 系列, 以便支持onvif等其他网络设备搜索
/// @see https://github.com/lishaoliang/l_sdk_doc
///  \n 错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_DISCOVER_H__
#define __L_SDK_DISCOVER_H__

#include "proto/l_type.h"
#include "l_sdk_define.h"

#if defined(__cplusplus)
extern "C" {
#endif


/// @brief 打开广播服务模块
/// @return int 错误码
L_SDK_API int l_sdk_discover_open(const char* p_param);


/// @brief 关闭广播服务模块
/// @return int 错误码
L_SDK_API int l_sdk_discover_close();


/// @brief 打开/关闭持续搜索
/// @return int 错误码
L_SDK_API int l_sdk_discover_run(bool8 b_open);


/// @brief 打开搜索之后, 获取当前网络中的设备
/// @param [out] **p_devs   设备列表
/// @return int 错误码
L_SDK_API int l_sdk_discover_get_devs(char** p_devs);


/// @brief 向某个sn设备发送广播请求
/// @param [in] *p_req     请求数据
/// @param [out] **p_res   回复复数据
/// @return int 错误码
L_SDK_API int l_sdk_discover_request(const char* p_req, char** p_res);


#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_DISCOVER_H__
//end
