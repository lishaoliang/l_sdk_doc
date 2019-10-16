///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/12/24
//
/// @file    l_sdk_err.h
/// @brief   错误码定义; 仅仅定义错误码,勿定义其他
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2018/12/24 0.1 创建文件
/// @see https://github.com/lishaoliang/l_sdk_doc
///  \n 错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_ERR_H__
#define __L_SDK_ERR_H__


#if defined(__cplusplus)
extern "C" {
#endif


/// @enum  l_sdk_err_t
/// @brief sdk组件错误码
typedef enum l_sdk_err_t_
{
    L_SDK_OK = 0,
    L_SDK_ERR_INIT,             ///< SDK未初始化, 或初始化错误
    L_SDK_ERR_TIME_OUT,         ///< 等待超时
    L_SDK_ERR_PARAM,            ///< 参数错误
    L_SDK_ERR_OPEN,             ///< 打开失败,或没有打开对应的对象
    L_SDK_ERR_NO_DATA,          ///< 无数据,或没有新数据刷新

    L_SDK_ERR_END = 0x0FFF
}l_sdk_err_t;


/// @enum  l_sdk_proto_err_t
/// @brief 网络协议错误码: 注意和 lua部分保持一致
typedef enum l_sdk_proto_err_t_
{
    L_SDK_PERR_B = 0x1000,                      ///< 协议错误码开始
    L_SDK_PERR_UNSUPPORT = L_SDK_PERR_B + 1,    ///< 不支持的协议命令
    L_SDK_PERR_NOTFOUND = L_SDK_PERR_B + 2,     ///< 未找到; 没找到数据,配置项,网页等
    L_SDK_PERR_PARAM = L_SDK_PERR_B + 3,        ///< 协议参数错误

    L_SDK_PERR_E = 0x7FFF                       ///< 协议错误码结束
}l_sdk_proto_err_t;


#if defined(__cplusplus)
}
#endif


#endif // __L_SDK_ERR_H__
//end
