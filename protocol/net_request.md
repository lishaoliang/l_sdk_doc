## 网络


### 1. 设置有线网口IPv4

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

### 2. 获取有线网口IPv4

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


### 3. 设置无线网口参数

* 请求

```javascript
{
  cmd : 'set_wireless',
  llssid : '123456',
  llauth : '123456',
  set_wireless : {
    type : 'sta',
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

* 无线使用方式: 1.'ap'模式,作为热点; 2.'sta'模式,作为终端连接到某热点
* 网络类型(仅'ap'模式有效):'2.4g','5g','2.4g,5g'
* 加密方式(仅'ap'模式有效): 'wpa/wpa2 psk','wpa2 psk','psk','none'

* 回复

```javascript
{
  cmd : "set_wireless",
  set_wireless : {
    code : 0
  }
}
```

### 4. 获取无线网口参数

* 请求

```javascript
{
  cmd : 'wireless',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : "wireless",
  wireless : {
    code : 0,
    type : 'sta',
    net : '2.4g',
    ssid : 'f701w-cut',
    passwd : '123456',
    enc : 'wpa2-psk'
  }
}
```
