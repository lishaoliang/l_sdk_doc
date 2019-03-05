## 组播发现

### 概述

* 组播地址: 239.209.219.229
* 端口: 23919
* 最大负载数据长度: 1340
* 接收发送全部采用组播方式,以免单播无法跨越不同网段

### 鉴权方案

* 未实现
* 方案1: 用户名,密码

```javascript
{
  login : {
    username : 'admin',
    passwd : '123456'
  }
}
```

* 方案2: 用户名,加密密码

```javascript
{
  login : {
    enc : 'base64'
    username : 'admin',
    passwd : 'xxxx'
  }
}
```


### 2. 搜索网内所有设备

* 未实现
* 请求

```javascript
// 二进制
// 无需附加字符串
```

* 回复

```javascript
{
  cmd : 'discover',
  sn : 'YDFE4EFDFESHEDFR',

  discover : {
    name : 'xxx',
    hw_ver : 'h1.0.0',
    sw_ver : 'v1.0.0',
    model : 'wifi-ipc',
    dev_type : 'ipc',
    chnn_max : 1,
    txt_enc : 'base64,xxx',
    md_enc : 'xxx'
  }
}
```

|  值域     | 类型       |   备注    |
|:---------:|:--------- |:--------- |
| name      | 字符串     | 用户定义的设备名称(utf8) |
| hw_ver    | 字符串     | 硬件版本 |
| sw_ver    | 字符串     | 软件版本 |
| model     | 字符串     | 型号 |
| dev_type  | 字符串     | 设备类型 |
| chnn_max  | 数值       | 视频最大通道数 |
| txt_enc   | 字符串     | 服务端支持的文本加密方式 |
| md_enc    | 字符串     | 服务端支持的媒体加密方式 |

### 3. 组播修改IP地址

* 未实现
* 有线网口1
* 请求

```javascript
{
  cmd : 'set_ipv4',
  sn : 'YDFE4EFDFESHEDFR',

  login : {
    username : 'admin',
    passwd : '123456'
  },

  set_ipv4 : {
    dhcp : false,
    ip : '127.0.0.1',
    gateway : '192.168.0.1',
    netmask : '255.255.255.0'
  }
}
```

* 回复

```javascript
{
  cmd : 'set_ipv4',
  sn : 'YDFE4EFDFESHEDFR',

  set_ipv4 : {
    code : 0
  }
}
```

### 4. 组播修改Wi-Fi的无线参数

* 未实现
* 请求

```javascript
{
  cmd : 'set_wifi',
  sn : 'YDFE4EFDFESHEDFR',

  login : {
    username : 'admin',
    passwd : '123456'
  },

  set_wifi : {
    type : 'router',
    net : '2.4g',
    ssid : 'f701w-cut',
    passwd : '123456',
    enc : 'wpa2-psk'
  }
}
```

|  值域     | 类型       |   备注    |
|:---------:|:--------- |:--------- |
| type      | 字符串     | 无线使用方式 |
| net       | 字符串     | 网络类型 |
| ssid      | 字符串     | 热点名称 |
| passwd    | 字符串     | 密码 |
| enc       | 字符串     | 加密方式 |

* 无线使用方式: 1.'ap'模式,作为热点; 2.'router'模式,作为终端连接到某热点
* 网络类型:'2.4g','5g','2.4g,5g'
* 加密方式: 'wpa/wpa2 psk','wpa2 psk','psk','none'

* 回复

```javascript
{
  cmd : 'set_wifi',
  sn : 'YDFE4EFDFESHEDFR',

  set_wifi : {
    code : 0
  }
}
```

### 5. 组播修改Wi-Fi的IP地址

* 未实现
* Wi-Fi网口1
* 请求

```javascript
{
  cmd : 'set_wifi_ipv4',
  sn : 'YDFE4EFDFESHEDFR',

  login : {
    username : 'admin',
    passwd : '123456'
  },

  set_wifi_ipv4 : {
    dhcp : false,
    ip : '127.0.0.1',
    gateway : '192.168.0.1',
    netmask : '255.255.255.0'
  }
}
```

* 回复

```javascript
{
  cmd : 'set_wifi_ipv4',
  sn : 'YDFE4EFDFESHEDFR',

  set_wifi_ipv4 : {
    code : 0
  }
}
```

### 附录: 组播二进制格式

```javascript
//二进制
```
