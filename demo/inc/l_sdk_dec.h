///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件 All Rights Reserved
//  Created: 2019/01/07
//
/// @file    l_sdk_dec.h
/// @brief   单路解码
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2019/01/07 0.1 创建文件
/// @see https://github.com/lishaoliang/l_sdk_doc
///  \n 错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
/// @warning 没有警告
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


/// @brief 打开一个解码器
/// @param [in] dec_id      用户自定义解码器id: [1-N]
/// @param [in] *p_param    打开参数
/// @return int 返回错误码
/// @note p_param 参数json格式:
///  \n { "pix_fmt" : "YUV420P_SEPARATE" }
///  \n pix_fmt 解码之后图像格式, 默认YUV420P_SEPARATE, 参见"proto/l_md_data.h" l_md_data_type_e
///  \n pix_fmt 取值['ARGB8888', 'RGB888', 'YUV420P_SEPARATE', 'ABGR8888', 'BGR888'
///  \n             'RGBA8888', 'BGRA8888']
L_SDK_API int l_sdk_dec_open(int dec_id, const char* p_param);


/// @brief 关闭解码器
/// @param [in] dec_id      解码器id
/// @return int 返回错误码
L_SDK_API int l_sdk_dec_close(int dec_id);


/// @brief 绑定解码器到某个登录id的特定流上
/// @param [in] dec_id      解码器id
/// @param [in] chnn        通道
/// @param [in] idx         流序号,主子码流
/// @param [in] md_id       媒体自定义id
/// @return int 返回错误码
L_SDK_API int l_sdk_dec_bind(int dec_id, int login_id, int chnn, int idx, int md_id);


/// @brief 解除解码器的绑定
/// @param [in] dec_id      解码器id
/// @return int 返回错误码
L_SDK_API int l_sdk_dec_unbind(int dec_id);


/// @brief 获取解码控制之后的原始媒体数据: 例如,L_MDDT_YUV420P_SEPARATE格式
/// @param [in] dec_id          解码器id
/// @param [out] **p_md_data    输出媒体数据指针
/// @return int 返回错误码
/// @note 返回0.表示取到了数据, p_md_data有效
///  \n 返回非0.表示没有取到数据的错误信息
///  \n 如果为25-30帧, 则理论调用此函数频率为45-60, 否则会导致数据积压, 解码器会丢弃部分数据
///  \n 如果为45-60帧, 则理论调用此函数频率为90-120, 否则会导致数据积压, 解码器会丢弃部分数据
///  \n 调用函数表示调用者自行处理数据
L_SDK_API int l_sdk_dec_get_md_data(int dec_id, l_md_data_t** p_md_data);


/// @brief 释放原始媒体数据
/// @param [in] *p_md_data    由函数l_sdk_dec_get_md_data得到的数据媒体数据
/// @return int 返回错误码
L_SDK_API int l_sdk_dec_free_md_data(l_md_data_t* p_md_data);



#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_DEC_H__
//end
