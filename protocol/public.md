## 3、公共请求

### 1. 探测包
* v1.0.0
* 在短连接上, 用于探测设备是否真实在线或保活授权信息
* 长连接有专属二进制定义,不需要此包做心跳

* 请求

```javascript
{
  cmd : "hello",
  llssid : "",
  llauth : ""
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
* v1.0.0
* 用于探测设备是否支持某些协议命令

* 请求

```javascript
{
  cmd : "support",
  llssid : "",
  llauth : ""
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
  llssid : "",
  llauth : ""
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
