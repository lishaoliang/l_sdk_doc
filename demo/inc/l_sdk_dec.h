///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, �人˴����� All Rights Reserved
//  Created: 2019/01/07
//
/// @file    l_sdk_dec.h
/// @brief   ��·����
/// @version 0.1
/// @author  ������
/// @history �޸���ʷ
///  \n 2019/01/07 0.1 �����ļ�
/// @see https://github.com/lishaoliang/l_sdk_doc
///  \n ������: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
/// @warning û�о���
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_DEC_H__
#define __L_SDK_DEC_H__

#include "proto/l_type.h"
#include "proto/l_media.h"
#include "proto/l_md_buf.h"
#include "proto/l_md_data.h"
#include "l_sdk_define.h"


#if defined(__cplusplus)
extern "C" {
#endif


/// @brief ��һ��������
/// @param [in] dec_id      �û��Զ��������id: [1-N]
/// @param [in] *p_param    �򿪲���
/// @return int ���ش�����
/// @note p_param ����json��ʽ:
///  \n { "pix_fmt" : "YUV420P_SEPARATE" }
///  \n pix_fmt ����֮��ͼ���ʽ, Ĭ��YUV420P_SEPARATE, �μ�"proto/l_md_data.h" l_md_data_type_e
///  \n pix_fmt ȡֵ['ARGB8888', 'RGB888', 'YUV420P_SEPARATE', 'ABGR8888', 'BGR888'
///  \n             'RGBA8888', 'BGRA8888']
L_SDK_API int l_sdk_dec_open(int dec_id, const char* p_param);


/// @brief �رս�����
/// @param [in] dec_id      ������id
/// @return int ���ش�����
L_SDK_API int l_sdk_dec_close(int dec_id);


/// @brief �󶨽�������ĳ����¼id���ض�����
/// @param [in] dec_id      ������id
/// @param [in] chnn        ͨ��
/// @param [in] idx         �����,��������
/// @param [in] md_id       ý���Զ���id
/// @return int ���ش�����
L_SDK_API int l_sdk_dec_bind(int dec_id, int login_id, int chnn, int idx, int md_id);


/// @brief ����������İ�
/// @param [in] dec_id      ������id
/// @return int ���ش�����
L_SDK_API int l_sdk_dec_unbind(int dec_id);


/// @brief ��ȡ�������֮���ԭʼý������: ����,L_MDDT_YUV420P_SEPARATE��ʽ
/// @param [in] dec_id          ������id
/// @param [out] **p_md_data    ���ý������ָ��
/// @return int ���ش�����
/// @note ����0.��ʾȡ��������, p_md_data��Ч
///  \n ���ط�0.��ʾû��ȡ�����ݵĴ�����Ϣ
///  \n ���Ϊ25-30֡, �����۵��ô˺���Ƶ��Ϊ45-60, ����ᵼ�����ݻ�ѹ, �������ᶪ����������
///  \n ���Ϊ45-60֡, �����۵��ô˺���Ƶ��Ϊ90-120, ����ᵼ�����ݻ�ѹ, �������ᶪ����������
///  \n ���ú�����ʾ���������д�������
L_SDK_API int l_sdk_dec_get_md_data(int dec_id, l_md_data_t** p_md_data);


/// @brief �ͷ�ԭʼý������
/// @param [in] *p_md_data    �ɺ���l_sdk_dec_get_md_data�õ�������ý������
/// @return int ���ش�����
L_SDK_API int l_sdk_dec_free_md_data(l_md_data_t* p_md_data);



#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_DEC_H__
//end
