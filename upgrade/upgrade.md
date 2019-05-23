## 客户请求服务端升级

### 1. 升级系统
* v1.0.7
* 请求

```javascript
{
  cmd : 'upgrade',
  llssid : '123456',
  llauth : '123456',
  upgrade : {
    username : 'admin',
    passwd : '123456'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| name      | 字符串(rw)  | 用户名称 |
| passwd    | 字符串(rw)  | 用户密码 |


* 回复

```javascript
{
  cmd : 'upgrade',
  upgrade : {
    code : 0
  }
}
```

### 2. 确认数据包数目
* v1.0.7
* 请求

```javascript
{
  cmd : 'upgrade_packs',
  llssid : '123456',
  llauth : '123456',
  upgrade_packs : {
    packs : 10,
    bits : 512
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| packs    | 数值(r)     | 发送的md包数目 |
| bits     | 数值(r)     | 发送的字节数目 |

* 回复

```javascript
{
  cmd : 'upgrade_packs',
  upgrade_packs : {
    code : 0,
    packs : 10,
    bits : 512
  }
}
```

### 3. 确认升级成功
* v1.0.7
* 协议仅仅需要保证所有数据包传递到服务端, 并被服务端处理
* 服务端会对升级包做二次校验, 以确认是否可以升级: 防止客户端欺骗, 升级包数据错误等
* 请求

```javascript
{
  cmd : 'upgrade_ok',
  llssid : '123456',
  llauth : '123456',
  upgrade_ok : {
    all_packs : 10,
    all_bits : 4096
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| all_packs | 数值(r)     | 所有md包数目 |
| all_bits  | 数值(r)     | 所有的字节数目 |

* 回复

```javascript
{
  cmd : 'upgrade_ok',
  upgrade_ok : {
    code : 0,
    all_packs : 10,
    all_bits : 4096
  }
}
```
