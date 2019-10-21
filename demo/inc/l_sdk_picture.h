///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, �人˴����� All Rights Reserved
//  Created: 2019/10/17
//
/// @file    l_sdk_picture.h
/// @brief   ͼƬ������ؽӿ�
/// @version 0.1
/// @author  ��ʿͨ
/// @history �޸���ʷ
/// @warning û�о���
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_PICTURE_H__
#define __L_SDK_PICTURE_H__


#include "proto/l_type.h"
#include "l_sdk_define.h"


#if defined(__cplusplus)
extern "C" {
#endif

/// @struct l_sdk_picture_frame_t
/// @brief  ͼƬ���ݽṹ��
typedef struct l_sdk_picture_frame_t_
{
    unsigned char* p_buffer;    ///< ���ͼƬ����buffer, ����ͼƬ�����ṩ, ���ͼƬ���ṩ�ɲ��ṩ
    int buffer_size;            ///< buffer����,��Ҫ���ڸ�֪�ڲ�����,��ֹԽ��
    int data_length;            ///< ���ݳ���,��Ҫ�������ͼƬʱ���ظ��û�
    int w;                      ///< ͼƬ��
    int h;                      ///< ͼƬ��
}l_sdk_picture_frame_t;


/// @brief ��������
/// @param [in]  *p_pic      ����ѹ��ͼƬ����
/// @param [in]  pic_len     ����ѹ��ͼƬ���ݳ���
/// @param [in]  pic_type    ����ѹ��ͼƬ��������: �ο� ffmpeg.AVCodecID; AV_CODEC_ID_MJPEG=7
/// @param [out] *p_out_w    ���ͼƬ��
/// @param [out] *p_out_h    ���ͼƬ��
/// @return int 0.�ɹ�; ��0.������
///  \n L_SDK_ERR_PARAM.�����������
///  \n L_SDK_ERR_OPEN.���ݵ��쳣���±�������޷���
///  \n L_SDK_ERR_NO_DATA.���ݶ�ȡ����, �޷���ȡ���
L_SDK_API int l_sdk_picture_size(const char* p_pic, int pic_len, int pic_type, int* p_out_w, int* p_out_h);


/// @brief ��һ��ѹ��ͼƬ�������Ų���
/// @param [in] *p_pic           ����ѹ��ͼƬ����
/// @param [in] pic_len          ����ѹ��ͼƬ���ݳ���
/// @param [in] pic_type         ����ѹ��ͼƬ��������: �ο� ffmpeg.AVCodecID; AV_CODEC_ID_MJPEG=7
/// @param [in/out] *p_out_frame ���ͼƬ��Ϣ,����ͼƬ���ݺ����ݳ���.���buffer�������û��ṩ,Ҳ������NULL,����Ҫ���û��ͷ�
/// @param quality_level         ͼƬ���� ���[0, 6]���
/// @return int 0.�ɹ�; ��0.������
///  \n L_SDK_ERR_PARAM.�����������
///  \n L_SDK_ERR_OPEN.���ݵ��쳣���±�������޷���
///  \n L_SDK_ERR_NO_DATA.����ת������, �������������
///  \n L_SDK_ERR_REPEAT.Ŀ������ԭ���ݿ��һ��,��ʽһ��, ����ת��
/// @note 
///  \n ���ͼƬ: p_out_frame->w, p_out_frame->h Ϊ���, ��ʾ��Ҫ���ŵ���Ŀ��ߴ�
///  \n ���p_out_frame->p_buffer = NULL, ��ʾ��sdk�����ڴ�, ʹ����Ϻ����l_sdk_picture_free�ͷ�
///  \n ���p_out_frame->p_buffer �ǿ�, ��ʾ�ɵ����������ڴ�, sdkֻ���������;�ڴ�����µ���������Լ��������ʵ��ڴ��С
///  \n �ڴ��С���԰����RGBA������ = w * h * 4
///  \n ��ֻ֧��pic_type=7, out_type=7 jepg��ʽ
L_SDK_API int l_sdk_picture_resize(const char* p_pic, int pic_len, int pic_type, l_sdk_picture_frame_t* p_out_frame, int out_quality, int out_type);


/// @brief �ͷ���sdk�������ͼƬ�ڴ�
/// @param [in] *p_frame    ͼƬ��Ϣ
/// @return ��
/// @note ע������ڴ���sdk����, ��ʹ�ô˺����ͷ�l_sdk_picture_frame_t.p_buffer
///  \n ���l_sdk_picture_frame_t.p_buffer�ɵ���������, ���ɵ��������ͷ�
L_SDK_API void l_sdk_picture_free(l_sdk_picture_frame_t* p_frame);


#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_PICTURE_H__
//end
