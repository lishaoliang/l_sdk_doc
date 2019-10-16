///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/12/29
//
/// @file    l_md_buf.h
/// @brief   媒体数据共享内存; 适用于内存资源丰富的平台: pc,手机等
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2018/12/29 0.1 创建文件
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_MD_BUF_H__
#define __L_MD_BUF_H__

#include "proto/l_type.h"
#include "proto/l_media.h"


#if defined(__cplusplus)
extern "C" {
#endif

#pragma pack(4)


/// @struct l_buf_t
/// @brief  基本缓存结构定义
typedef struct l_buf_t_
{
    char*   p_buf;          ///< 缓存指针
    int     buf_len;        ///< 缓存长度

    int     start;          ///< 数据起始位置
    int     end;            ///< 数据结束位置
}l_buf_t;


/// @struct l_md_buf_t
/// @brief  带引用计数,共享版缓存结构
typedef struct l_md_buf_t_
{
    uint32  tc;                     ///< 系统滴答数[生产者读写,消费者只读]
    uint32  md_id;                  ///< 媒体id[生产者读写,消费者只读]

    uint8   ver;                    ///< frame头版本[生产者读写,消费者只读]
    uint8   resv1;
    uint16  resv2;

    union
    {
        l_frame_t   f_v1;           ///< ver = L_MD_F_VER时, 有效[生产者读写,消费者只读]
    };

    struct
    {
        char*       p_buf;          ///< 缓存指针[生产者读写,消费者只读]
        int         buf_len;        ///< 缓存长度[生产者读写,消费者只读]

        int         start;          ///< 数据起始位置[生产者读写,消费者只读]
        int         end;            ///< 数据结束位置[生产者读写,消费者只读]
    };

    struct
    {
        void*       p_count;        ///< 引用计数器; [消费者不可见]
    };
}l_md_buf_t;

#pragma pack()


#if defined(__cplusplus)
}
#endif

#endif // __L_MD_BUF_H__
//end
