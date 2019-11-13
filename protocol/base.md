## 6、基本信息

### 1. 获取设备基本信息
* v1.0.2
* 请求

```javascript
{
  cmd : 'system',
  llssid : '123456',
  llauth : '123456',
}
```

* 回复

```javascript
{
  cmd : 'system',
  system : {
    code : 0,
    sn : 'YDFE4EFDFESHEDFR',
    hw_ver : 'h1.0.0',
    sw_ver : 'v1.0.0',
    build_time : '2019-04-30 14:24:56 +08:00',
    model : 'wifi-ipc',
    dev_type : 'ipc',
    chnn_num : 1,
    disk_num : 0,
    mac : '00:13:09:FE:45:78',
    mac_wireless : '00:13:09:FE:45:79'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数值(r)     | 错误码 |
| sn        | 字符串(r)   | 设备SN |
| hw_ver    | 字符串(r)   | 硬件版本 |
| sw_ver    | 字符串(r)   | 软件版本 |
| build_time| 字符串(r)   | 编译时间 |
| model     | 字符串(r)   | 型号 |
| dev_type  | 字符串(r)   | 设备类型 |
| chnn_num  | 数值(r)     | 最大通道数目 |
| disk_num  | 数值(r)     | 最大磁盘数目 |
| mac       | 字符串(r)   | 有线网口MAC地址 |
| mac_wireless       | 字符串(r)   | 无线网口MAC地址 |


### 2. 获取设备名称
* v1.0.2
* 获取默认设备名称: 'default_name'

* 请求

```javascript
{
  cmd : 'name',
  llssid : '123456',
  llauth : '123456',
}
```

* 回复

```javascript
{
  cmd : 'name',
  name : {
    code : 0,
    name : 'xxx'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数值(r)     | 错误码 |
| name      | 字符串(rw)   | 设备名称 |

### 3. 设置设备名称
* 不支持
* 请求

```javascript
{
  cmd : 'set_name',
  llssid : '123456',
  llauth : '123456',
  set_name : {
    name : 'xxx'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| name      | 字符串(rw)   | 设备名称 |

* 回复

```javascript
{
  cmd : 'set_name',
  set_name : {
    code : 0
  }
}
```

### 4. 获取设备时间
* 不支持

* 请求

```javascript
{
  cmd : 'time',
  llssid : '123456',
  llauth : '123456',
}
```

* 回复

```javascript
{
  cmd : 'time',
  system : {
    code : 0,
    time : '125487511',
    date : '2019/03/06 08:15:05 GMT+08:00'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数值(r)     | 错误码 |
| time      | 字符串(rw)  | 系统GMT时间(基于0时区)(毫秒ms) |
| date      | 字符串(rw)  | 系统当前基于当前时区的时间 |


### 5. 设置设备时间
* 不支持
* 请求

```javascript
{
  cmd : 'set_time',
  llssid : '123456',
  llauth : '123456',
  set_time : {
    time : '125487511',
    date : '2019/03/06 08:15:05 GMT+08:00'
  }
}
```

* 回复

```javascript
{
  cmd : 'set_time',
  set_time : {
    code : 0,
  }
}
```

### 6. 获取时区
* 不支持
* 获取默认时区: 'default_timezone'
* 请求

```javascript
{
  cmd : 'timezone',
  llssid : '123456',
  llauth : '123456',
}
```

* 回复

```javascript
{
  cmd : 'timezone',
  timezone : {
    code : 0,
    timezone : 'GMT+08:00',
    range : {
      timezone : {'GMT-12:00', 'GMT', 'GMT+08:00', 'GMT+12:00'}
    }
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数值(r)     | 错误码 |
| timezone  | 字符串(rw)  | 时区 |
| range     | (r)        | 参数取值范围 |


### 7. 设置时区
* 不支持

* 请求

```javascript
{
  cmd : 'set_timezone',
  llssid : '123456',
  llauth : '123456',
  set_timezone : {
    timezone : 'GMT+08:00'
  }
}
```

* 回复

```javascript
{
  cmd : 'set_timezone',
  set_timezone : {
    code : 0
  }
}
```

### 8. 设置NTP校时
* v1.1.1

* 请求

```javascript
{
  cmd : 'set_ntp',
  llssid : '123456',
  llauth : '123456',
  set_ntp : {
    enable : false,
    server : 'ntp1.aliyun.com',
    port : 123,
    interval : ‭604800‬
  }
}
```

* 回复

```javascript
{
  cmd : 'set_ntp',
  set_ntp : {
    code : 0
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数值(r)     | 错误码 |
| enable    | 布尔(rw)    | 是否使能NTP |
| server    | 字符串(rw)  | NTP服务器IPv4或域名 |
| port      | 数值(rw)    | NTP服务器端口 |
| interval  | 数值(rw)    | NTP校时时间间隔(单位秒) |


### 9. 获取NTP校时
* v1.1.1

* 获取默认NTP校时: 'default_ntp'
* 请求

```javascript
{
  cmd : 'ntp',
  llssid : '123456',
  llauth : '123456',
}
```

* 回复

```javascript
{
  cmd : 'ntp',
  ntp : {
    code : 0,
    enable : false,
    server : 'ntp1.aliyun.com',
    port : 123,
    interval : ‭604800‬,
    range : {
      port : {
        min : 1,
        max : 65536
      },
      interval : {
        min : 3600,
        max : 5184000
      }
    },
    recommend : {
      server : {'ntp1.aliyun.com', 'ntp2.aliyun.com'}
    }
  }
}
```

* ntp.recommend.server : {...} 表示推荐使用的时间同步服务器


### 10. 立即进行NTP校时
* v1.1.1

* 请求

```javascript
{
  cmd : 'ntp_sync',
  llssid : '123456',
  llauth : '123456',
  ntp_sync : {
    server : 'ntp1.aliyun.com',
    port : 123,
  }
}
```

* 回复

```javascript
{
  cmd : 'ntp_sync',
  ntp_sync : {
    code : 0
  }
}
```
