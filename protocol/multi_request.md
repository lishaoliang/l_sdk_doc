## 批量协议请求

### 注意事项
* 命令请求有次序，服务端依照次序处理
* 批量协议请求最大个数 NA
* 批量请求排除命令: "login","logout"

### 参考示例

* 请求

```javascript
{
  cmd : "system,hello",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "system,hello",
  system : {
    code : 0,
    model : "wifi-ipc-3516a"
  }
  hello : {
    code : 0,
    msg : "welcome!"
  }
}
```
