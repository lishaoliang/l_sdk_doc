///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2018, 武汉舜立软件 All Rights Reserved
//  Created: 2018/12/22
//
/// @file    l_sdk_media.h
/// @brief   媒体数据流
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2018/12/22 0.1 创建文件
/// @see https://github.com/lishaoliang/l_sdk_doc
///  \n 错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////
#ifndef __L_SDK_MEDIA_H__
#define __L_SDK_MEDIA_H__

#include "proto/l_type.h"
#include "proto/l_media.h"
#include "proto/l_md_buf.h"
#include "proto/l_net.h"
#include "l_sdk_define.h"

#if defined(__cplusplus)
extern "C" {
#endif


/// @brief 监听媒体数据的回调函数
/// @note 禁止在回调函数中使用耗时函数, 否则会阻塞整个媒体接收线程
typedef int(*l_sdk_media_cb)(void* p_obj, int protocol, int id, int chnn, int idx, int md_id, l_md_buf_t* p_data);


/// @brief 添加媒体数据监听者
/// @return int 0.成功; 非0.错误码
L_SDK_API int l_sdk_md_add_listener(char* p_name, l_sdk_media_cb cb_media, void* p_obj);


/// @brief 移除媒体数据监听者
/// @return int 0.成功; 非0.错误码
L_SDK_API int l_sdk_md_remove_listener(char* p_name);


/// @brief 清除从内存缓存中的残留的媒体数据; 用于确保使用l_sdk_md_get得到最新的数据
/// @param [in] id        登录id
/// @param [in] chnn      通道
/// @param [in] idx       流序号
/// @param [in] md_id     媒体id
/// @return int 0.成功清除数据; L_SDK_ERR_NO_DATA.无数可以被清除
L_SDK_API int l_sdk_md_clear(int id, int chnn, int idx, int md_id);


/// @brief 从内存缓存中获取最新的媒体数据
/// @param [in] id        登录id
/// @param [in] chnn      通道
/// @param [in] idx       流序号
/// @param [in] md_id     媒体id
/// @param [out] **p_data 媒体数据
/// @return int 0.成功; 非0.错误码
/// @note 如果返回0, 则p_data的引用计数已经被加1, 调用者需要调用l_sdk_md_buf_sub函数释放数据
L_SDK_API int l_sdk_md_get(int id, int chnn, int idx, int md_id, l_md_buf_t** p_data);


/// @brief 媒体数据块引用计数加1
/// @param [in] *p_data 媒体数据
/// @return int 总共的计数次数
L_SDK_API int l_sdk_md_buf_add(l_md_buf_t* p_data);


/// @brief 媒体数据块引用计数减1
/// @param [in] *p_data 媒体数据
/// @return int 总共的计数次数
L_SDK_API int l_sdk_md_buf_sub(l_md_buf_t* p_data);


#if defined(__cplusplus)
}
#endif

#endif // __L_SDK_MEDIA_H__
//end
