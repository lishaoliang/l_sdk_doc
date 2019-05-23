## 7、网络

### 1. 设置有线网口IPv4
* v1.0.2
* 请求

```javascript
{
  cmd : 'set_ipv4',
  llssid : '23456',
  llauth : '123456',
  set_ipv4 : {
    dhcp : true,
    ip : '192.168.7.230',
    gateway : '192.168.7.1',
    netmask : '255.255.255.0',
    dns1 : '192.168.7.1',
    dns2 : ''
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
* v1.0.2
* 获取默认时区: 'default_ipv4'
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
    dhcp : true,
    ip : '192.168.7.230',
    gateway : '192.168.7.1',
    netmask : '255.255.255.0',
    dns1 : '192.168.7.1',
    dns2 : ''
  }
}
```

### 3. 设置无线网口参数
* v1.0.2
* 请求

```javascript
{
  cmd : 'set_wireless',
  llssid : '123456',
  llauth : '123456',
  set_wireless : {
    type : 'sta',
    net : '5g',
    ssid : 'f701w-cut',
    passwd : '123456',
    enc : 'wpa2-psk',
    range : {
      type : {'ap', 'sta'},
      net : {'2.4g', '5g'},
      enc : {'none', 'psk', 'wpa2 psk', 'wpa/wpa2 psk'}
    }
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
* v1.0.2
* 获取默认时区: 'default_wireless'
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
    net : '5g',
    ssid : 'f701w-cut',
    passwd : '123456',
    enc : 'wpa2-psk'
  }
}
```

### 5. 获取无线网口ipv4
* v1.0.2
* 获取默认时区: 'default_wireless_ipv4'
* 请求

```javascript
{
  cmd : 'wireless_ipv4',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : "wireless_ipv4",
  wireless_ipv4 : {
    code : 0,
    dhcp : true,
    ip : '192.168.7.230',
    gateway : '192.168.7.1',
    netmask : '255.255.255.0',
    dns1 : '192.168.7.1',
    dns2 : ''
  }
}
```

### 6. 设置无线网口ipv4
* v1.0.2
* 请求

```javascript
{
  cmd : 'set_wireless_ipv4',
  llssid : '123456',
  llauth : '123456',
  set_wireless_ipv4 : {
    code : 0,
    dhcp : true,
    ip : '192.168.7.230',
    gateway : '192.168.7.1',
    netmask : '255.255.255.0',
    dns1 : '192.168.7.1',
    dns2 : ''
  }
}
```

* 回复

```javascript
{
  cmd : "set_wireless_ipv4",
  set_wireless_ipv4 : {
    code : 0
  }
}
```

### 5. 获取数据服务端口
* 不支持
* 获取默认服务端口: 'default_net_port'
* 暂不支持

* 请求

```javascript
{
  cmd : 'net_port',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : "net_port",
  net_port : {
    code : 0,
    port : 80
  }
}
```


### 6. 设置数据服务端口
* 不支持
* 暂不支持

* 请求

```javascript
{
  cmd : 'set_net_port',
  llssid : '123456',
  llauth : '123456',
  set_net_port : {
    port : 80
  }
}
```

* 回复

```javascript
{
  cmd : "set_net_port",
  set_net_port : {
    code : 0
  }
}
```

### 5. 获取UPNP信息
* 不支持

* 请求

```javascript
{
  cmd : 'upnp',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : "upnp",
  upnp : {
    code : 0,
    analbe : false,
    auto : false,
    external_port : 80
  }
}
```


### 6. 设置UPNP信息
* 不支持

* 请求

```javascript
{
  cmd : 'set_upnp',
  llssid : '123456',
  llauth : '123456',
  set_upnp : {
    analbe : false,
    auto : false,
    external_port : 80
  }
}
```

* 回复

```javascript
{
  cmd : "set_upnp",
  set_upnp : {
    code : 0
  }
}
```


### 7. 获取DDNS信息
* 不支持

* 请求

```javascript
{
  cmd : 'ddns',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : "ddns",
  ddns : {
    code : 0,
    analbe : false,
    ddns : ''
    range {

    }
  }
}
```

### 8. 设置DDNS信息
* 不支持

* 请求

```javascript
{
  cmd : 'set_ddns',
  llssid : '123456',
  llauth : '123456',
  set_ddns : {
    analbe : false,
    ddns : ''
  }
}
```

* 回复

```javascript
{
  cmd : "set_ddns",
  set_ddns : {
    code : 0
  }
}
```
