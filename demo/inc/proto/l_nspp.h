///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/11/28
//
/// @file    l_nspp.h
/// @brief   net slice packet protocol 网络分包协议
/// @version 0.3 
/// @note 定义网络数据格式需要注意以下点
///  \n 1. 协议兼容性, 注意版本延续
///  \n 2. 注意与Websocket协议对接兼容性, 即本协议可以不修改或少量修改转换为Websocket协议实现
///  \n 3. 协议可以实现为短连接,长连接
///  \n 4. 协议涵盖文本, 二进制(音视频, 文件等)定义
///  \n 5. 添加子协议机制: 扩大协议适用范围, 依据业务性质, 选择适用子协议
/// @history 修改历史
/// @author  李绍良
///  \n 2018/11/28 0.1  创建文件
///  \n 2019/3/5   0.2  添加本协议可转换为WebSocket实现的基本出发点
///  \n 2019/4/17  0.3  添加子协议机制
///  \n     -- NSPP             基础协议标记
///  \n     --------- MEDIA     媒体流,文本通信子协议
///  \n     --------- UPGRADE   (客户端向设备服务端请求)升级子协议
///  \n     --------- FTP       文件传输子协议
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_NSPP_H__
#define __L_NSPP_H__

#include "proto/l_type.h"


#if defined(__cplusplus)
extern "C" {
#endif


/// @def   L_NSPP_FLAG
/// @brief 网络分包协议魔数标记
#define L_NSPP_FLAG         0xFA5A5F


/// @def   L_NSPP_VER
/// @brief 网络分包协议版本
#define L_NSPP_VER          0x1


/// @enum  l_nspp_opt_e
/// @brief 分包组合包标记
///   完整包格式: F
///   分包格式:   B [C] [C] E
typedef enum l_nspp_opt_e_
{
    L_NSPP_F = 0x0,     ///< FULL 完整包
    L_NSPP_B = 0x1,     ///< BEGIN 开始包
    L_NSPP_C = 0x2,     ///< CONTINUE 中间包
    L_NSPP_E = 0x3      ///< END 结束包
}l_nspp_opt_e;


/// @enum  l_nspp_type_e
/// @brief 网络分包类型; 这里主要考虑兼容 WebSocket
///  \n WebSocket主要定义为: 文本,二进制,PING,PONG
///  \n 因此这里除非是明确不兼容Websocket部分, 否则只可定义文本, 二进制, 心跳这三项
typedef enum l_nspp_type_e_
{
    L_NSPP_NULL = 0x0, ///< NULL
    L_NSPP_MD   = 0x1, ///< 二进制数据;(媒体帧, 文件等)(完整nspp+data小于64K)
    L_NSPP_TXT  = 0x2, ///< 文本会话(完整nspp+data小于2M)

    L_NSPP_HEART= 0xE, ///< 心跳: 附加数据长度为0;心跳包从TXT中剥离出来主要为提高执行效率; 客户端发起心跳,服务端回应
    L_NSPP_END  = 0xF  ///< 结束
}l_nspp_type_e;


/// @enum  l_nspp_sub_proto_e
/// @brief nspp子协议
typedef enum l_nspp_sub_proto_e_
{
    L_NSPP_MEDIA        = 0,        ///< 媒体流,文本通信子协议
    L_NSPP_UPGRADE      = 1,        ///< (客户端向设备服务端请求)升级子协议
    L_NSPP_FTP          = 2,        ///< 文件传输子协议

    L_NSPP_SUB_P_END    = 0x7FFF    ///< 子协议结束
}l_nspp_sub_proto_e;


#pragma pack(4)


/// @struct l_nspp_t
/// @brief  网络传输媒体分包格式头
///  \n 1.任何版本不可变更
///  \n 2.网络传输二进制包(媒体包等)格式: l_nspp_t + [l_frame_t] + [0001 xxx 0001] < 64K
///  \n 3.网络传输文本包格式: l_nspp_t + [txt] < 2M
///  \n 4.网络传输心跳包格式: l_nspp_t = 12字节
typedef struct l_nspp_h_t_
{
    uint32 flag : 24;       ///< 魔数标记: L_NSPP_FLAG   
    uint32 ver : 4;         ///< 网络协议版本: L_NSPP_VER
    uint32 opt : 4;         ///< 分包组合: l_nspp_opt_e: F,B,C,E

    uint32 len : 24;        ///< 数据包长度(不包含本结构体): [type = L_NSPP_MD, len < 64K][type = L_NSPP_TXT, len < 2M]
    uint32 type : 4;        ///< 网络分包类型: l_nspp_type_e
    uint32 resv : 4;        ///< 0
    ///- 8字节

    uint16 resv2;           ///< 0
    uint16 sub_proto;       ///< 子协议: l_nspp_sub_proto_e
    ///- [8] + 4字节 = 12字节
}l_nspp_t;

#pragma pack()


//////////////////////////////////////////////////////////////////////////

#ifdef NDEBUG
#define L_NSPP_CHECK(p_nspp_)    ((void)0)
#else
#define L_NSPP_CHECK(p_nspp_) \
{ \
    assert(L_NSPP_FLAG == (p_nspp_)->flag); \
    assert(L_NSPP_VER == (p_nspp_)->ver); \
    assert((p_nspp_)->opt <= L_NSPP_E); \
}
#endif


#ifdef __cplusplus
}
#endif

#endif // __L_NSPP_H__
//end
