## 4、权限

### 1. 登入
* v1.0.0
* 登入到设备
* 众多协议命令必须先登入设备

* 请求

```javascript
{
  cmd : "login",
  llssid : "123456",
  llauth : "123456",
  login : {
    username : "admin",
    passwd : "123456"
  }
}
```

* 回复

```javascript
{
  cmd : "login",
  login : {
    code : 0,
    llssid : "xxxx",
    llauth : "xxxx",
  }
}
```

### 2. 登出
* v1.0.0
* 登出设备

* 请求

```javascript
{
  cmd : "logout",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "logout",
  logout : {
    code : 0
  }
}
```
