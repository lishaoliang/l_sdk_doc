## 三、网络发现接口

```
/// @brief 打开搜索服务模块
/// @return int 错误码
L_SDK_API int l_sdk_discover_open(const char* p_param);

/// @brief 关闭搜索服务模块
/// @return int 错误码
L_SDK_API int l_sdk_discover_close();

/// @brief 打开/关闭持续搜索
/// @return int 错误码
L_SDK_API int l_sdk_discover_run(bool8 b_open);

/// @brief 打开搜索之后, 获取当前网络中的设备
/// @param [out] **p_devs   设备列表
/// @return int 错误码
L_SDK_API int l_sdk_discover_get_devs(char** p_devs);
```

### 1. 示例
* 可以l_sdk_discover_open之后,使用一段时间之后再l_sdk_discover_close
* 调用l_sdk_discover_run(true)函数之后,会向局域网发送组播/广播搜索请求,不需要搜索功能时,需要调用l_sdk_discover_run(false)关闭

```
  l_sdk_discover_open('');
  l_sdk_discover_run(true);

  sleep(2);

  char* p_devs = NULL;
  if (0 == l_sdk_discover_get_devs(&p_devs))
  {
    printf(p_devs);
  }

  if (NULL != p_devs)
  {
    l_sdk_free(p_devs);
  }

  l_sdk_discover_run(false);
  l_sdk_discover_close();
```
