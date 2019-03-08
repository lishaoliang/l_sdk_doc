## 1、基本接口

```
/// @brief sdk初始化
int l_sdk_init(const char* p_config);

/// @brief sdk退出
void l_sdk_quit();

/// @brief 登入到某个设备
int l_sdk_login(int* p_id, const char* p_param);

/// @brief 登出某个设备
int l_sdk_logout(int id);

/// @brief 向设备发起请求
int l_sdk_request(int id, const char* p_req, char** p_res);

/// @brief 释放通过"l_sdk"函数得到字符串
void l_sdk_free(char* p_res);
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
