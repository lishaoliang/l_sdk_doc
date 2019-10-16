///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/11/22
//
/// @file    l_media.h
/// @brief   媒体流,文本通信子协议: L_NSPP_MEDIA
///  \n 一.本子协议目标:
///  \n  1.文本通信
///  \n  2.流媒体服务
///  \n 二.封包格式:
///  \n  1.文本协议(F包):     l_nspp_t + json < 2M
///  \n  2.视频帧格式(B,F包): l_nspp_t + l_frame_t + [0001 xxx] + [001 xxx] + [0001 xxx] < 64K
///  \n  3.音频帧格式(B,F包): l_nspp_t + l_frame_t + [xxx] < 64K
///  \n  4.JPEG帧格式(B,F包): l_nspp_t + l_frame_t + jpeg < 64K
///  \n  5.视频帧,音频帧,JPEG帧(C,E包): l_nspp_t + [data] < 64K
///  \n 三.兼容WebSocket协议: 将l_nspp_t头域替换为ws头域
/// @version 0.2
/// @author  李绍良
/// @history 修改历史
///  \n 2018/11/22  0.1     创建文件
///  \n 2019/4/17   0.2     约定本子协议细节
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_MEDIA_H__
#define __L_MEDIA_H__

#include "proto/l_type.h"

#if defined(__cplusplus)
extern "C" {
#endif


/// @def   L_MD_F_VER
/// @brief V1媒体数据帧版本
#define L_MD_F_VER          0x01


#pragma pack(4)

/// @struct l_frame_t
/// @brief  V1媒体帧定义
///  完整视频格式: l_frame_t + [0001 xxx] + [001 xxx] + [0001 xxx]
///  音频,其他类型格式: l_frame_t + [xxx]
///  任何版本最开头struct域, 不可变更
typedef struct l_frame_t_
{
    struct
    {
        uint8   size;           ///< 本结构体长度 <= 256
        uint8   ver;            ///< 版本:L_MD_F_VER
        uint8   fmt;            ///< 媒体格式: [l_md_fmt_e], L_MF_H264, L_MF_H265
        uint8   v_type;         ///< 视频帧类型: [l_mv_type_e] fmt = H264, H265时 有效

        uint32  len;            ///< 媒体包长度: 不包含本结构体
    };
    ///- 8字节

    union {
        struct {
            uint32 w;           ///< (无效,即将弃用)视频宽
            uint32 h;           ///< (无效,即将弃用)视频高
        };

        struct {
            uint16 track;       ///< 音频,声道数: 1单声道, 2双声道
            uint16 bit_wide;    ///< 音频,采样位宽: 8, 16, 32
            uint32 sample;      ///< 音频,采样率: 8,000 Hz, 44,100 Hz, 96,000 Hz, 192,000 Hz
        };
    };
    ///- [8] + 8字节

    int64   time;               ///< 时间戳 (微妙)
    uint16  chnn;               ///< 通道
    uint16  idx;                ///< 流序号
    ///- [8 + 8] + 12字节

    uint32  resv2;              ///< 预留2: 默认0
    ///- [8 + 8 + 12] + 4字节 = 32字节
}l_frame_t;

#pragma pack()


/// @enum  l_md_idx_e
/// @brief 通道媒体流序号
typedef enum l_md_idx_e_
{
    L_MDIDX_V1      = 0x0000,   ///< 视频主码流
    L_MDIDX_V2      = 0x0001,   ///< 视频子码流
    L_MDIDX_V3      = 0x0002,   ///< 第三视频流

    L_MDIDX_A1      = 0x0020,   ///< 第一音频流
    L_MDIDX_A2      = 0x0021,   ///< 第二音频流
    L_MDIDX_A3      = 0x0022,   ///< 第三音频流

    L_MDIDX_P1      = 0x0040,   ///< 第一图片流
    L_MDIDX_P2      = 0x0041,   ///< 第二图片流


    L_MDIDX_PB_V1   = 0x1000,   ///< 回看(历史)视频主码流
    L_MDIDX_PB_V2   = 0x1001,   ///< 回看(历史)视频子码流
    L_MDIDX_PB_V3   = 0x1002,   ///< 回看(历史)第三视频流

    L_MDIDX_PB_A1   = 0x1020,   ///< 回看(历史)第一音频流
    L_MDIDX_PB_A2   = 0x1021,   ///< 回看(历史)第二音频流
    L_MDIDX_PB_A3   = 0x1022,   ///< 回看(历史)第二音频流

    L_MDIDX_PB_P1   = 0x1040,   ///< 回看(历史)第一图片流
    L_MDIDX_PB_P2   = 0x1041,   ///< 回看(历史)第二图片流

    L_MDIDX_END     = 0xFFFF    ///< 结束
}l_md_idx_e;


/// @enum  l_md_fmt_e
/// @brief 媒体包编码格式(uint8)
typedef enum l_md_fmt_e_
{
    L_FMT_NULL      = 0x00,     ///< NULL

    L_FMT_VIDEO_B   = 0x01,     ///< 视频定义开始
    L_FMT_H264      = 0x02,     ///< 视频h264格式
    L_FMT_H265      = 0x03,     ///< 视频h265格式
    L_FMT_VIDEO_E   = 0x0F,     ///< 视频定义结束

    L_FMT_AUDIO_B   = 0x10,     ///< 音频定义开始
    L_FMT_G711A     = 0x11,     ///< 音频g711.a格式
    L_FMT_G711U     = 0x12,     ///< 音频g711.u格式
    L_FMT_ADPCM     = 0x13,     ///< 音频adpcm
    L_FMT_LPCM      = 0x14,     ///< 音频编码格式LPCM
    L_FMT_G726      = 0x15,     ///< 音频编码格式G726
    L_FMT_AAC       = 0x16,     ///< 音频aac格式
    L_FMT_AUDIO_E   = 0x2F,     ///< 音频定义结束

    L_FMT_TXT_B     = 0x30,     ///< 文本定义开始
    L_FMT_TXT_E     = 0x3F,     ///< 文本定义结束

    L_FMT_PIC_B     = 0x40,     ///< 图片定义开始
    L_FMT_JPEG      = 0x41,     ///< 图片JPEG格式
    L_FMT_PIC_E     = 0x5F,     ///< 图片定义结束

    L_FMT_END       = 0xFF      ///< 结束
}l_md_fmt_e;


/// @enum  l_mv_type_e
/// @brief 视频流类型
typedef enum l_mv_type_e_
{
    L_MVT_NULL  = 0x0, ///< NULL
    L_MVT_I     = 0x1, ///< I帧
    L_MVT_P     = 0x2, ///< P帧
    L_MVT_B     = 0x3, ///< B帧

    L_MVT_END   = 0xF  ///< 结束
}l_mv_type_e;


//////////////////////////////////////////////////////////////////////////

#ifdef NDEBUG
#define L_NSPP_CHECK_MPB(p_mpb_) ((void)0)
#else
#define L_NSPP_CHECK_MPB(p_mpb_) \
{ \
    l_nspp_t* p_nspp_tmp_ = (l_nspp_t*)((p_mpb_)->data.p_buf + (p_mpb_)->data.start); \
    L_NSPP_CHECK(p_nspp_tmp_); \
    if (L_NSPP_F == p_nspp_tmp_->opt || L_NSPP_B == p_nspp_tmp_->opt) \
    { \
        l_frame_t* p_frame_tmp_ = (l_frame_t*)((p_mpb_)->data.p_buf + (p_mpb_)->data.start + sizeof(l_nspp_t)); \
        assert(sizeof(l_frame_t) == p_frame_tmp_->size); \
        assert(L_MD_F_VER == p_frame_tmp_->ver); \
        assert(p_frame_tmp_->v_type <= L_MVT_B);\
        assert(p_frame_tmp_->len <= 4 * 1024 * 1024);\
    } \
}
#endif


#ifdef __cplusplus
}
#endif

#endif // __L_MEDIA_H__
//end
