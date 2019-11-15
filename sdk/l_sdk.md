## 一、基本接口

```
/// @brief sdk初始化
/// @param [in] *p_config json格式的sdk初始配置信息
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
L_SDK_API int l_sdk_init(const char* p_config);


/// @brief sdk退出
L_SDK_API void l_sdk_quit();


/// @brief 登入到某个设备
/// @param [out] *p_id   输出成功之后的登录id
/// @param [in] *p_param json格式的参数信息: 具体细节参考sdk文档
/// \n 例如: {"ip"="127.0.0.1","port"=3456,"login"={"username"="admin","passwd"="123456"}}
/// @return int 0.成功; 非0.错误码
L_SDK_API int l_sdk_login(int* p_id, const char* p_param);


/// @brief 登出某个设备
/// @param [in] id 登录id
/// @return int 0.成功; 非0.错误码
L_SDK_API int l_sdk_logout(int id);


/// @brief 向设备发起请求
/// @param [in]  id      登录id
/// @param [in]  *p_req  请求的数据(json格式)
/// @param [out] **p_res 如果请求成功,输出设备回复的协议数据(json格式)
/// @return int 0.成功; 非0.错误码
/// @note 具体的请求,回复数据格式参见 协议文档
L_SDK_API int l_sdk_request(int id, const char* p_req, char** p_res);


/// @brief 释放通过"l_sdk"函数得到字符串
/// @param [in] *p_res  待释放的字符串内存
L_SDK_API void l_sdk_free(char* p_res);
```

### 1. 函数'l_sdk_init'
* 功能：初始化SDK所有模块
* 必须在使用所有SDK接口之前调用
* 暂不支持自定义配置，参数p_config=""即可

* 原型

```
int l_sdk_init(const char* p_config);
```

* 参数

```
/// @param [in] *p_config json格式的sdk初始配置信息
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```

### 2. 函数'l_sdk_quit'
* 功能：软件结束时，退出SDK，释放资源
* 必须在使用完毕后，再调用此接口

* 原型

```
void l_sdk_quit();
```


### 3. 函数'l_sdk_login'
* 功能：登入到某设备

* 原型

```
int l_sdk_login(int* p_id, const char* p_param);
```

* 参数

```
/// @param [out] *p_id  如果登入成功, 则输出ID值
/// @param [in] *p_param  登录参数

示例1：p_param =
{
  ip : '192.168.1.247',
  port : 80,
  login : {
    username : 'admin',
    passwd : '123456'
  }
}

示例1：p_param =
{
  protocol : 'nspp',        // 'nspp', 'rtsp'
  ip : '192.168.1.247',
  port : 80,
  login : {
    username : 'admin',
    passwd : '123456'
  }
}

```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```


### 4. 函数'l_sdk_logout'
* 功能：登出

* 原型

```
int l_sdk_logout(int id);
```

* 参数

```
/// @param [in] id  由l_sdk_login函数输出的ID值
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```


### 5. 函数'l_sdk_request'
* 功能：登录后，向设备发起请求

* 原型

```
int l_sdk_request(int id, const char* p_req, char** p_res);
```

* 参数

```
/// @param [in]  id       登录ID
/// @param [in]  *p_req   请求json信息
/// @param [out] **p_res  如果请求成功,则为设备回复的json信息
示例：id = 1000

p_param =
{
  cmd : 'open_stream'
  open_stream : {
    chnn : 0,
    idx : 0
  }
}

p_res =
{
  cmd : 'open_stream',
  open_stream : {
    code : 0
  }
}
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```

* 注意

```
返回值0，仅仅表示从服务端取到回复结果
命令是否成功执行, 还需要看回复的'code'值
输出的内存p_res, 需要使用函数l_sdk_free释放
```

### 6. 函数'l_sdk_free'
* 功能：释放中间字符串内存

* 原型

```
void l_sdk_free(char* p_res);
```

* 参数

```
/// @param [in]  *p_res   sdk输出的字符串
```
