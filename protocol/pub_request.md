## 公共请求

### 1. 心跳
* 用于保持应用层连接
* 用于探测设备是否真实在线情况
* 长连接: 客户端每10S定期向服务端发送此请求,保持连接
* 长连接: 服务端约定默认20S没有任何应用层数据(包含接收发送), 即断开连接

* 请求

```javascript
{
  cmd : "hello",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "hello",
  hello : {
    code : 0,
    msg : "welcome!"
  }
}
```

### 2. 获取支持的命令集合
* 用于测试阶段探测设备是否支持某些协议命令

* 请求

```javascript
{
  cmd : "support",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "support",
  support : {
    code : 0,
    cmds : "hello, encrypt, support…"
  }
}
```

### 3. 加密秘钥
* 暂不支持

* 请求

```javascript
{
  cmd : "encrypt",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "encrypt",
  encrypt : {
    code : 0,
    key : "123456"
  }
}
```
