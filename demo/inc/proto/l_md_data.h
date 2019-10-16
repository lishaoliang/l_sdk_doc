///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, �人˴����� All Rights Reserved
//  Created: 2019/01/03
//
/// @file    l_md_data.h
/// @brief   ����֮���ԭʼý������: ͼƬ,��Ƶ
/// @version 0.2
/// @author  ������
/// @history �޸���ʷ
///  \n 2019/01/03 0.1 �����ļ�
///  \n 2019/06/19 0.2 ����l_md_data_t�ṹ��, ֧��RGBϵ�����ظ�ʽ
/// @warning û�о���
///////////////////////////////////////////////////////////////////////////
#ifndef __L_MD_DATA_H__
#define __L_MD_DATA_H__

#include "proto/l_type.h"
#include "proto/l_md_buf.h"

#if defined(__cplusplus)
extern "C" {
#endif


/// @enum  l_md_data_type_e
/// @brief ԭʼý�����ݸ�ʽ
typedef enum l_md_data_type_e_
{
    L_MDDT_NULL                 = 0,
    L_MDDT_ARGB8888             = 1,    ///< [ARGB][ARGB][ARGB]
    L_MDDT_ARGB8888_SEPARATE    = 2,    ///< [AAAA][RRRR][GGGG][BBBB]

    L_MDDT_RGB888               = 3,    ///< [RGB][RGB][RGB]
    L_MDDT_RGB888_SEPARATE      = 4,    ///< [RRR][GGG][BBB]

    L_MDDT_YUV420P              = 5,    ///< [YUV][YUV][YUV]...[Y00][Y00][Y00]
    L_MDDT_YUV420P_SEPARATE     = 6,    ///< [YYY][UUU][VVV]

    L_MDDT_ARGB1555             = 7,    ///< [ARGB][ARGB][ARGB]

    L_MDDT_ABGR8888             = 41,   ///< [ABGR][ABGR][ABGR]
    L_MDDT_BGR888               = 43,   ///< [BGR][BGR[BGR]
    L_MDDT_RGBA8888             = 45,   ///< [RGBA][RGBA][RGBA]
    L_MDDT_BGRA8888             = 47,   ///< [BGRA][BGRA][BGRA]

}l_md_data_type_e;


#pragma pack(4)


/// @struct l_md_data_t
/// @brief  ԭʼý��ͼ������
typedef struct l_md_data_t_
{
    int             type;   ///< ��������: l_md_data_type_e
    int64           time;   ///< ʱ���

    union
    {
        struct
        {
            int     w;      ///< ͼ���
            int     h;      ///< ͼ���
        };
    };

    union
    {
        struct
        {
            char*   p_y;                ///<  Y����: L_MDDT_YUV420P_SEPARATE
            int     pitch_y;            ///<  Y����, �п��

            char*   p_u;                ///<  U����: L_MDDT_YUV420P_SEPARATE
            int     pitch_u;            ///<  U����, �п��

            char*   p_v;                ///<  V����: L_MDDT_YUV420P_SEPARATE
            int     pitch_v;            ///<  V����, �п��
        };

        struct
        {
            union
            {
                char*   p_rgb;          ///<  L_MDDT_RGB888
                char*   p_bgr;          ///<  L_MDDT_BGR888
            };
            int         pitch_888;      ///<  24λͼ, �п��
        };

        struct
        {
            union
            {
                char*   p_argb;         ///<  L_MDDT_ARGB8888
                char*   p_abgr;         ///<  L_MDDT_ABGR8888
                char*   p_rgba;         ///<  L_MDDT_RGBA8888
                char*   p_bgra;         ///<  L_MDDT_BGRA8888
            };
            int         pitch_8888;     ///< 32λͼ, �п��
        };
    };

    l_buf_t             data;           ///<  ���ݴ�Ż���
}l_md_data_t;

#pragma pack()


#if defined(__cplusplus)
}
#endif

#endif // __L_MD_DATA_H__
//end
