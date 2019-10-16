///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2019/01/03
//
/// @file    l_md_data.h
/// @brief   解码之后的原始媒体数据: 图片,音频
/// @version 0.2
/// @author  李绍良
/// @history 修改历史
///  \n 2019/01/03 0.1 创建文件
///  \n 2019/06/19 0.2 调整l_md_data_t结构体, 支持RGB系列像素格式
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_MD_DATA_H__
#define __L_MD_DATA_H__

#include "proto/l_type.h"
#include "proto/l_md_buf.h"

#if defined(__cplusplus)
extern "C" {
#endif


/// @enum  l_md_data_type_e
/// @brief 原始媒体数据格式
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
/// @brief  原始媒体图像数据
typedef struct l_md_data_t_
{
    int             type;   ///< 数据类型: l_md_data_type_e
    int64           time;   ///< 时间戳

    union
    {
        struct
        {
            int     w;      ///< 图像宽
            int     h;      ///< 图像高
        };
    };

    union
    {
        struct
        {
            char*   p_y;                ///<  Y分量: L_MDDT_YUV420P_SEPARATE
            int     pitch_y;            ///<  Y分量, 行夸距

            char*   p_u;                ///<  U分量: L_MDDT_YUV420P_SEPARATE
            int     pitch_u;            ///<  U分量, 行夸距

            char*   p_v;                ///<  V分量: L_MDDT_YUV420P_SEPARATE
            int     pitch_v;            ///<  V分量, 行夸距
        };

        struct
        {
            union
            {
                char*   p_rgb;          ///<  L_MDDT_RGB888
                char*   p_bgr;          ///<  L_MDDT_BGR888
            };
            int         pitch_888;      ///<  24位图, 行夸距
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
            int         pitch_8888;     ///< 32位图, 行夸距
        };
    };

    l_buf_t             data;           ///<  数据存放缓存
}l_md_data_t;

#pragma pack()


#if defined(__cplusplus)
}
#endif

#endif // __L_MD_DATA_H__
//end
