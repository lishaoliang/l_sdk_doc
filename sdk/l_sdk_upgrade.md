## 四、设备升级接口
* 使用函数l_sdk_request(0, req, res)

### 1. 请求升级设备
* 请求

```javascript
{
  cmd : 'upgrade',
  llssid : '123456',
  llauth : '123456',
  ip : '192.168.1.247',
  port : 80,
  path : 'D:/xxx/xxx/xxx.lpk'
  upgrade : {
    username : 'admin',
    passwd : '123456'
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| ip        | 字符串    | 目标IP地址 |
| port      | 数值      | 目标升级端口 |
| path      | 字符串    | *.lpk升级包路径 |
| username  | 字符串    | 用户名 |
| passwd    | 字符串    | 密码 |

* 回复

```javascript
{
  cmd : "upgrade",
  upgrade : {
    code : 0
  }
}
```


### 2. 查询升级状态
* status_upgrade

* 请求

```javascript
{
  cmd : 'status_upgrade',
  ip : '192.168.1.247',
  port : 80
}
```

* 回复

```javascript
{
  cmd : "status_upgrade",
  status_upgrade : {
    code : 0,
    percentage : 10,
    status : 'doing'
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| percentage| 数值      | 升级进度百分比 |
| status    | 字符串    | 'doing':正在升级; 'done':完成; |

* 状态为 'done',且升级进度为 100, 则为成功升级
