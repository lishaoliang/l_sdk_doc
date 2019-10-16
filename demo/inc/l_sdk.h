///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/12/22
//
/// @file    l_sdk.h
/// @brief   sdk接口; 目标支持PC,手机等内存,CPU资源充足的平台
///  \n 各个函数参数具体细节参见: 私有协议文档, SDK文档
///  \n sdk接口设计原则: 1.兼容公司各种设备; 2.不得任意变更接口; 3.sdk版本本身兼容性; 4.精简接口
/// @version 0.2
/// @author  李绍良
/// @history 修改历史
///  \n 2018/12/22 0.1 创建文件
///  \n 2019/04/13 0.2 将网络搜索从主工程中剔除, 成为独立搜索摸索模块
///  \n  搜索模块预留支持 nspp广播, onvif组播等第三方搜索
/// @see https://github.com/lishaoliang/l_sdk_doc
///  \n 错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_H__
#define __L_SDK_H__


#include "proto/l_type.h"
#include "l_sdk_define.h"
#include "l_sdk_err.h"
#include "l_sdk_discover.h"
#include "l_sdk_media.h"
#include "l_sdk_dec.h"

#if defined(__cplusplus)
extern "C" {
#endif


/// @brief sdk初始化
/// @param [in] *p_config json格式的sdk初始配置信息
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
L_SDK_API int l_sdk_init(const char* p_config);


/// @brief sdk退出
L_SDK_API void l_sdk_quit();


/// @brief 登入到某个设备
/// @param [out] *p_id   输出成功之后的登录id
/// @param [in] *p_param json格式的参数信息: 具体细节参考sdk文档
/// \n 例如: {"ip"="127.0.0.1","port"=3456,"login"={"username"="admin","passwd"="123456"}}
/// @return int 0.成功; 非0.错误码
L_SDK_API int l_sdk_login(int* p_id, const char* p_param);


/// @brief 登出某个设备
/// @param [in] id 登录id
/// @return int 0.成功; 非0.错误码
L_SDK_API int l_sdk_logout(int id);


/// @brief 向设备发起请求
/// @param [in]  id      登录id
/// @param [in]  *p_req  请求的数据(json格式)
/// @param [out] **p_res 如果请求成功,输出设备回复的协议数据(json格式) 
/// @return int 0.成功; 非0.错误码
/// @note 具体的请求,回复数据格式参见 协议文档
L_SDK_API int l_sdk_request(int id, const char* p_req, char** p_res);


/// @brief 释放通过"l_sdk"函数得到字符串
/// @param [in] *p_res  待释放的字符串内存
L_SDK_API void l_sdk_free(char* p_res);


#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_H__
//end
