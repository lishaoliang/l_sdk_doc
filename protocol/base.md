## 基本信息

### 1. 获取设备基本信息

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
| model     | 字符串(r)   | 型号 |
| dev_type  | 字符串(r)   | 设备类型 |
| chnn_num  | 数值(r)     | 最大通道数目 |
| disk_num  | 数值(r)     | 最大磁盘数目 |
| mac       | 字符串(r)   | 有线网口MAC地址 |
| mac_wireless       | 字符串(r)   | 无线网口MAC地址 |


### 2. 获取设备名称
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
* 暂不支持
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
* 暂不支持

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

### 8. 获取NTP校时
* 暂不支持

* 获取NTP校时: 'default_ntp'
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
    interval : '1H',
    range {
      server : {
        {'ntp1.aliyun.com', '123'},
        {'ntp2.aliyun.com', '123'}
      },
      interval : {'12H', '6H', '4H', '2H', '1H', '30M', '20M', '10M'}
    }
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数字(r)     | 错误码 |
| enable    | 布尔(rw)    | 是否使能NTP |
| server    | 字符串(rw)  | NTP服务器 |
| port      | 数字(rw)    | NTP服务器端口 |
| interval  | 字符串(rw)  | NTP校时时间间隔 |


### 9. 设置NTP校时
* 暂不支持

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
    interval : '1H'
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
