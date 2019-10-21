///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件 All Rights Reserved
//  Created: 2019/10/17
//
/// @file    l_sdk_picture.h
/// @brief   图片处理相关接口
/// @version 0.1
/// @author  商士通
/// @history 修改历史
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_PICTURE_H__
#define __L_SDK_PICTURE_H__


#include "proto/l_type.h"
#include "l_sdk_define.h"


#if defined(__cplusplus)
extern "C" {
#endif

/// @struct l_sdk_picture_frame_t
/// @brief  图片数据结构体
typedef struct l_sdk_picture_frame_t_
{
    unsigned char* p_buffer;    ///< 存放图片数据buffer, 输入图片必须提供, 输出图片可提供可不提供
    int buffer_size;            ///< buffer长度,主要用于告知内部函数,防止越界
    int data_length;            ///< 数据长度,主要用于输出图片时返回给用户
    int w;                      ///< 图片宽
    int h;                      ///< 图片高
}l_sdk_picture_frame_t;


/// @brief 函数描述
/// @param [in]  *p_pic      输入压缩图片数据
/// @param [in]  pic_len     输入压缩图片数据长度
/// @param [in]  pic_type    输入压缩图片数据类型: 参考 ffmpeg.AVCodecID; AV_CODEC_ID_MJPEG=7
/// @param [out] *p_out_w    输出图片宽
/// @param [out] *p_out_h    输出图片高
/// @return int 0.成功; 非0.错误码
///  \n L_SDK_ERR_PARAM.输出参数错误
///  \n L_SDK_ERR_OPEN.数据等异常导致编解码器无法打开
///  \n L_SDK_ERR_NO_DATA.数据读取错误, 无法获取宽高
L_SDK_API int l_sdk_picture_size(const char* p_pic, int pic_len, int pic_type, int* p_out_w, int* p_out_h);


/// @brief 对一张压缩图片进行缩放操作
/// @param [in] *p_pic           输入压缩图片数据
/// @param [in] pic_len          输入压缩图片数据长度
/// @param [in] pic_type         输入压缩图片数据类型: 参考 ffmpeg.AVCodecID; AV_CODEC_ID_MJPEG=7
/// @param [in/out] *p_out_frame 输出图片信息,返回图片数据和数据长度.输出buffer可以由用户提供,也可输入NULL,但都要由用户释放
/// @param quality_level         图片质量 最差[0, 6]最好
/// @return int 0.成功; 非0.错误码
///  \n L_SDK_ERR_PARAM.输出参数错误
///  \n L_SDK_ERR_OPEN.数据等异常导致编解码器无法打开
///  \n L_SDK_ERR_NO_DATA.数据转换错误, 导致无输出数据
///  \n L_SDK_ERR_REPEAT.目标宽高与原数据宽高一致,格式一致, 无需转换
/// @note 
///  \n 输出图片: p_out_frame->w, p_out_frame->h 为入参, 表示需要缩放到的目标尺寸
///  \n 如果p_out_frame->p_buffer = NULL, 表示由sdk申请内存, 使用完毕后调用l_sdk_picture_free释放
///  \n 如果p_out_frame->p_buffer 非空, 表示由调用者申请内存, sdk只是填充数据;在此情况下调用则必须自己给出合适的内存大小
///  \n 内存大小可以按最大RGBA来计算 = w * h * 4
///  \n 暂只支持pic_type=7, out_type=7 jepg格式
L_SDK_API int l_sdk_picture_resize(const char* p_pic, int pic_len, int pic_type, l_sdk_picture_frame_t* p_out_frame, int out_quality, int out_type);


/// @brief 释放在sdk中申请的图片内存
/// @param [in] *p_frame    图片信息
/// @return 无
/// @note 注意如果内存由sdk申请, 则使用此函数释放l_sdk_picture_frame_t.p_buffer
///  \n 如果l_sdk_picture_frame_t.p_buffer由调用者申请, 则由调用则负责释放
L_SDK_API void l_sdk_picture_free(l_sdk_picture_frame_t* p_frame);


#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_PICTURE_H__
//end
