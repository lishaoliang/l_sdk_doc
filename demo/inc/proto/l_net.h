///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/11/22
//
/// @file    l_net.h
/// @brief   网络部分公共定义,勿添加其他
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2018/11/22 0.1  创建文件
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_NET_H__
#define __L_NET_H__

#include "proto/l_type.h"

#if defined(__cplusplus)
extern "C" {
#endif

/// @def   L_NET_TAIL
/// @brief 网络缓存最少空闲字节
#define L_NET_TAIL          4


/// @def   L_NET_MIN_BUF
/// @brief 网络接收缓存最小值
#define L_NET_MIN_BUF       4 * 1024


/// @def   L_NET_MD_BUF
/// @brief 媒体数据接收缓存
#define L_NET_MD_BUF        64 * 1024


/// @def   L_NET_TIME_OUT
/// @brief 网络连接超时 20S
/// \n 推荐:由客户端发起的心跳数据间隔 10S
#define L_NET_TIME_OUT      20000


/// @def   L_NET_SMALL_HT_MAX
/// @brief 网络使用到的hashtable桶大小
///  \ 例如ht_u32_t, 额外: L_NET_HT_MAX * 4 + N * 12
///  \ 1000 约为 4K + N * 12 + N * Key
#define L_NET_SMALL_HT_MAX  1000


/// @def   L_NET_HT_MAX
/// @brief 网络使用到的hashtable桶大小
///  \ 例如ht_u32_t, 额外: L_NET_HT_MAX * 4 + N * 12
///  \ 10000 约为 40K + N * 12 + N * Key
#define L_NET_HT_MAX        10000


/// @def   L_NET_LARGE_HT_MAX
/// @brief 网络使用到的较大hashtable桶大小
///  \ 例如ht_u32_t, 额外: L_NET_HT_MAX * 4 + N * 12
///  \ 20000 约为 80K + N * 12 + N * Key
#define L_NET_LARGE_HT_MAX  20000


/// @enum  l_net_def_e
/// @brief 网络状态 OR 标准流程产生的错误, 勿定义其他细节
typedef enum l_net_def_e_
{
    L_NET_OK       = 0x0000,    ///< 网络一切正常
    L_NET_CLOSE,                ///< 主动关闭连接, 还可以发送残留数据
    L_NET_ERR,                  ///< 网路错误(读写socket返回-1引发),l_socket_param_t.err_code域记录错误码
    L_NET_DISCONN,              ///< 断开连接(读写socket返回0引发)
    L_NET_TIMEOUT,              ///< 网络超时(长时间无数据读写引发)
    L_NET_OUT_MEM,              ///< 内存溢出或数据包超过定义内存最大限制
    L_NET_ERR_PROTO,            ///< 数据的协议格式解析错误
    L_NET_ERR_REPEAT,           ///< 数据重复或已存在key等

    L_NET_NO_P_ENV = 0x0100,    ///< 没有协议连接环境
    L_NET_NO_PARSER,            ///< 未找到解析协议

    L_NET_CONNECT  = 0x0E00,    ///< 新连接加入

    L_NET_DEF_END  = 0x0FFF     ///< 定义结束

}l_net_def_e;


/// @enum  l_net_flag_e
/// @brief 网络常用标记
typedef enum l_net_flag_e_
{
    L_NET_WRITE    = 0x0001,    ///< 有数据 等待写
}l_net_flag_e;


/// @enum  l_net_protocol_e
/// @brief 网络协议类型
///  \n L_NET_NSPP子协议定义: l_nspp_sub_proto_e
typedef enum l_net_protocol_e_
{
    L_NET_P_NULL = 0,       ///< 暂未找到协议
    L_NET_UNKNOWN,          ///< 明确是未知协议
    L_NET_HTTP,             ///< http[TCP]
    L_NET_RTSP,             ///< rtsp[TCP]
    L_NET_WS,               ///< websocket[TCP]

    L_NET_NSPP = 20,        ///< nspp[TCP]: v1私有协议
    L_NET_NSPP_MULTICAST,   ///< nspp组播[UDP]: v1私有组播, 仅供网络发现,精简文本协议,不得定义业务协议, 不得传输媒体流
    L_NET_NSPP_BROADCAST,   ///< nspp广播[UDP]: v1私有广播, 仅供网络发现使用, 不得用于其他用途

    L_NET_P_USER = 1000,    ///< 用户自定协议

    L_NET_P_END  = 0x7FFF   ///< 主协议结束
}l_net_protocol_e;


/// @def   L_NET_PROTO_MAIN
/// @brief 获取主协议
#define L_NET_PROTO_MAIN(proto_)    ((int)(proto_) & 0xFFFF)


/// @def   L_NET_PROTO_SUB
/// @brief 获取子协议
#define L_NET_PROTO_SUB(proto_)     (((int)(proto_) >> 16) & 0xFFFF)


/// @def   L_NET_PROTO
/// @brief 主子协议标记值
#define L_NET_PROTO(main_, sub_)    (((int)(sub_) << 16) | ((int)(main_)))



#if defined(__cplusplus)
}
#endif

#endif // __L_NET_H__
//end
