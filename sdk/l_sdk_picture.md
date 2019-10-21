## 六、访问媒体数据接口

```
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


/// @brief 获取压缩图片尺寸
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
```

### 1. 获取压缩图片尺寸'l_sdk_picture_size'
* 功能：获取压缩图片的宽高

* 原型

```
int l_sdk_picture_size(const char* p_pic, int pic_len, int pic_type, int* p_out_w, int* p_out_h);
```

* 参数

```
/// @param [in]  *p_pic      输入压缩图片数据
/// @param [in]  pic_len     输入压缩图片数据长度
/// @param [in]  pic_type    输入压缩图片数据类型: 参考 ffmpeg.AVCodecID; AV_CODEC_ID_MJPEG=7
/// @param [out] *p_out_w    输出图片宽
/// @param [out] *p_out_h    输出图片高
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
///  \n L_SDK_ERR_PARAM.输出参数错误
///  \n L_SDK_ERR_OPEN.数据等异常导致编解码器无法打开
///  \n L_SDK_ERR_NO_DATA.数据读取错误, 无法获取宽高
```


### 2. 将一张压缩图片进行缩放操作'l_sdk_picture_resize'
* 功能：缩放一张压缩图片
* 目前仅支持jpeg格式
* 如果由SDK申请内存, 则需要使用 l_sdk_picture_free(p_out_frame), 释放数据

* 原型

```
int l_sdk_picture_resize(const char* p_pic, int pic_len, int pic_type, l_sdk_picture_frame_t* p_out_frame, int out_quality, int out_type);
```

* 参数

```
/// @param [in] *p_pic           输入压缩图片数据
/// @param [in] pic_len          输入压缩图片数据长度
/// @param [in] pic_type         输入压缩图片数据类型: 参考 ffmpeg.AVCodecID; AV_CODEC_ID_MJPEG=7
/// @param [in/out] *p_out_frame 输出图片信息,返回图片数据和数据长度.输出buffer可以由用户提供,也可输入NULL,但都要由用户释放
/// @param quality_level         图片质量 最差[0, 6]最好
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
///  \n L_SDK_ERR_PARAM.输出参数错误
///  \n L_SDK_ERR_OPEN.数据等异常导致编解码器无法打开
///  \n L_SDK_ERR_NO_DATA.数据转换错误, 导致无输出数据
///  \n L_SDK_ERR_REPEAT.目标宽高与原数据宽高一致,格式一致, 无需转换
```

* 注意
```
/// @note
///  \n 输出图片: p_out_frame->w, p_out_frame->h 为入参, 表示需要缩放到的目标尺寸
///  \n 如果p_out_frame->p_buffer = NULL, 表示由sdk申请内存, 使用完毕后调用l_sdk_picture_free释放
///  \n 如果p_out_frame->p_buffer 非空, 表示由调用者申请内存, sdk只是填充数据;在此情况下调用则必须自己给出合适的内存大小
///  \n 内存大小可以按最大RGBA来计算 = w * h * 4
///  \n 暂只支持pic_type=7, out_type=7 jepg格式
```


### 3. 释放由SDK申请的图片内存'l_sdk_picture_free'
* 功能：释放在SDK中申请的图片内存

* 原型

```
void l_sdk_picture_free(l_sdk_picture_frame_t* p_frame);
```

* 参数

```
/// @param [in] *p_frame    图片信息
```

* 注意
```
/// @note 注意如果内存由sdk申请, 则使用此函数释放l_sdk_picture_frame_t.p_buffer
///  \n 如果l_sdk_picture_frame_t.p_buffer由调用者申请, 则由调用则负责释放
```

### 4.参考示例
* https://github.com/lishaoliang/l_sdk_doc/blob/master/demo/cpp/stream/t_stream_pic.c
