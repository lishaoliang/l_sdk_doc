## 媒体流

### 1. 请求实时媒体流

* 请求

```javascript
{
  cmd : "open_stream",
  llssid : "123456",
  llauth : "123456",
  open_stream : {
    chnn : 0,
    idx : 0,
    md_id : 0
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn    | 0         | 通道 |
| idx     | 0         | 流序号: 主码流,子码流,音频,图片等 |
| md_id   | 0[可选]   | 媒体id: 用于区分同一个连接中同时请求多份流序号相同的码流; 由客户端决定 |

* 回复

```javascript
{
  cmd : "open_stream",
  open_stream : {
    code : 0
  }
}
```

* 备注
   1. [流序号idx说明](https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream_idx.md)
   2. 媒体md_id值由客户端决定, 取值范围[0 ~ 2^24]
   3. 暂不支持:媒体md_id


### 2. 关闭实时媒体流

* 请求

```javascript
{
  cmd : "close_stream",
  llssid : "123456",
  llauth : "123456",
  close_stream : {
    chnn : 0,
    idx : 0,
    md_id : 0
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn    | 0         | 通道 |
| idx     | 0         | 流序号: 主码流,子码流,音频,图片等 |
| md_id   | 0[可选]   | 媒体id: 用于区分同一个连接中同时请求多份流序号相同的码流; 由客户端决定 |

* 回复

```javascript
{
  cmd : "close_stream",
  close_stream : {
    code : 0
  }
}
```

### 3. 设置实时流参数

* 请求

```javascript
{
  cmd : "set_stream",
  llssid : "123456",
  llauth : "123456",
  set_stream : {
    chnn : 0,
    idx : 0,
    fmt : 'h264',
    rc_mode : 'vbr'
    w : 1920,
    h : 1080,
    quality : 'hight',
    frame_rate : 25,
    bitrate : 4096,
    i_interval : 90
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn      | 0         | 通道 |
| idx       | 0         | 实时流序号: 主码流,子码流,音频,图片等 |
| fmt       | 'h264'    | 编码格式: 'h264','h265','jpeg' |
| rc_mode   | 'vbr'     | 定码流'cbr',编码流'vbr' |
| w         | 1920      | 宽度 |
| h         | 1080      | 高度 |
| quality   | 'high'    | 图像质量: 'highest', 'higher', 'high','middle','low','lower', 'lowest' |
| frame_rate| 25        | 帧率[1,30] |
| bitrate   | 4096      | 码流比特率[128,6M] |
| i_interval| 90        | I帧间隔[25,90] |

* 回复

```javascript
{
  cmd : "set_stream",
  set_stream : {
    code : 0
  }
}
```

* 备注
   1. [idx 实时流序号说明](https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream_idx.md)
   2. [fmt 流格式说明](https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream_fmt.md)

### 4. 获取实时流参数

* 请求

```javascript
{
  cmd : "stream",
  llssid : "123456",
  llauth : "123456",
  stream : {
    chnn : 0,
    idx : 0
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn      | 0         | 通道 |
| idx       | 0         | 实时流序号: 主码流,子码流,音频,图片等 |


* 回复

```javascript
{
  cmd : "stream",
  stream : {
    code : 0,
    chnn : 0,
    idx : 0,
    fmt : 'h264',
    rc_mode : 'vbr'
    w : 1920,
    h : 1080,
    quality : 'hight',
    frame_rate : 25,
    bitrate : 4096,
    i_interval : 90
  }
}
```


### 5. 设置图像参数

* 请求

```javascript
{
  cmd : "set_image",
  llssid : "123456",
  llauth : "123456",
  set_image : {
    chnn : 0,
    idx : 0,
    bright : 128,
    contrast : 128,
    saturation : 128,
    hue : 128
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| bright    | 128       | 亮度[0,255] |
| contrast  | 128       | 对比度[0,255] |
| saturation| 128       | 饱和度[0,255] |
| hue       | 128       | 色度[0,255] |

* 备注
   1. 统一约定取值范围[0,255]
   2. 统一约定128为默认环境下最优设定
   3. 如果协议约定值与实际设备对应不上, 由各个设备自行处理映射关系


* 回复

```javascript
{
  cmd : "set_image",
  set_image : {
    code : 0
  }
}
```

### 6. 获取图像参数
* 请求

```javascript
{
  cmd : "image",
  llssid : "123456",
  llauth : "123456",
  image : {
    chnn : 0,
    idx : 0
  }
}
```

* 回复

```javascript
{
  cmd : "image",
  image : {
    code : 0,
    chnn : 0,
    idx : 0
  }
}
```
