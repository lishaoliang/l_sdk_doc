## 网络

### 1. 获取IPv4

* 请求

```javascript
{
  cmd : "ipv4",
  llssid : "123456",
  llauth : "123456",
}
```

* 回复

```javascript
{
  cmd : "ipv4",
  ipv4 : {
    code : 0,
    dhcp : false,
    ip : "127.0.0.1",
    gateway : "192.168.0.1",
    netmask : "255.255.255.0"
  }
}
```

### 2. 修改IPv4

* 请求

```javascript
{
  cmd : "set_ipv4",
  llssid : "123456",
  llauth : "123456",
  set_ipv4 : {
    dhcp : false,
    ip : "127.0.0.1",
    gateway : "192.168.0.1",
    netmask : "255.255.255.0"
  }
}
```

* 回复

```javascript
{
  cmd : "set_ipv4",
  set_ipv4 : {
    code : 0
  }
}
```
