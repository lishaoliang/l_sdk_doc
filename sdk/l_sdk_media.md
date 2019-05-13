## 二、访问媒体数据接口

```
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
```

### 1. 回调函数'l_sdk_media_cb'
* 功能：添加监听函数之后, 当sdk从网络上获得数据之后, 回调此函数给调用者

* 原型

```
static int cb_sdk_media(void* p_obj, int protocol, int id, int chnn, int idx, int md_id, l_md_buf_t* p_data);
```

* 参数

```
/// @param [in] *p_obj    为l_sdk_md_add_listener函数的指定的第三个参数
/// @param [in] protocol  协议编号(含主子协议)
/// @param [in] id        登录ID
/// @param [in] chnn      设备通道号,取值范围[0, N)
/// @param [in] idx       流序号,参见:https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream_idx.md
/// @param [in] md_id     媒体流编号,暂为0.
/// @param [in] p_data    媒体原始数据
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
```

### 2. 添加监听函数'l_sdk_md_add_listener'
* 功能：添加监听, 当sdk从网络上获得数据之后, 通过函数l_sdk_media_cb回调此函数给调用者

* 原型

```
int l_sdk_md_add_listener(char* p_name, l_sdk_media_cb cb_media, void* p_obj);
```

* 参数

```
/// @param [in] *p_name   监听对象名称
/// @param [in] cb_media  监听回调函数
/// @param [in] *p_obj    监听回调对象
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
```

### 3. 移除监听'l_sdk_md_remove_listener'
* 功能：移除监听

* 原型

```
int l_sdk_md_remove_listener(char* p_name);
```

* 参数

```
/// @param [in] *p_name   监听对象名称
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
```


### 4. 清除缓存数据'l_sdk_md_clear'
* 功能：清除部分流的缓存
* 目前支持图片流

* 原型

```
int l_sdk_md_clear(int id, int chnn, int idx, int md_id);
```

* 参数

```
/// @param [in] id    登录ID
/// @param [in] chnn  通道
/// @param [in] idx   流序号: 目前只支持图片流
/// @param [in] md_id 暂不支持: 0
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
```


### 5. 获取媒体缓存数据'l_sdk_md_get'
* 功能：从SDK中获取媒体流的最后一帧缓存数据
* 目前支持图片流
* 需要使用 l_sdk_md_buf_sub(p_data), 释放数据

* 原型

```
int l_sdk_md_get(int id, int chnn, int idx, int md_id, l_md_buf_t** p_data);
```

* 参数

```
/// @param [in] id    登录ID
/// @param [in] chnn  通道
/// @param [in] idx   流序号: 目前只支持图片流
/// @param [in] md_id 暂不支持: 0
/// @param [out] **p_data 输出媒体数据
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
```


### 6. 获取媒体缓存数据'l_sdk_md_buf_add'
* 功能：对媒体数据缓存计数加1

* 原型

```
int l_sdk_md_buf_add(l_md_buf_t* p_data);
```

* 参数

```
/// @param [in] *p_data    媒体数据计数加1
```

* 返回值

```
/// @return int 总共的计数次数
```


### 7. 获取媒体缓存数据'l_sdk_md_buf_sub'
* 功能：对媒体数据缓存计数减1
* 当计数为0时, 数据缓存被释放

* 原型

```
int l_sdk_md_buf_sub(l_md_buf_t* p_data);
```

* 参数

```
/// @param [in] *p_data    媒体数据计数减1
```

* 返回值

```
/// @return int 总共的计数次数
```


### 8.参考示例
* https://github.com/lishaoliang/l_sdk_doc/blob/master/demo/cpp/stream/t_stream.c
