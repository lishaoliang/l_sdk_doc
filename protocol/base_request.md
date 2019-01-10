## 基本信息

### 1. 设备基本信息

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
    chnn_max : 1,
    mac : '00:13:09:FE:45:78'
  }
}
```

|  值域     | 类型       |   备注    |
|:---------:|:--------- |:--------- |
| code      | 数值     | 错误码 |
| sn        | 字符串   | 设备SN |
| hw_ver    | 字符串   | 硬件版本 |
| sw_ver    | 字符串   | 软件版本 |
| model     | 字符串   | 型号 |
| dev_type  | 字符串   | 设备类型 |
| chnn_max  | 数值     | 最大通道数目 |
| mac       | 字符串   | MAC地址 |
