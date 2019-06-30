## 8、媒体流

### 1. 请求实时媒体流
* v1.0.2
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
| chnn     | 0         | 通道 |
| idx      | 0         | 流序号: 主码流,子码流,音频,图片等 |
| md_id    | 0         | 媒体id: 用于区分同一个连接中同时请求多份流序号相同的码流; 由客户端决定 |

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
* v1.0.2
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

### 3. 设置实时视频流参数
* v1.0.2
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
    rc_mode : 'vbr',
    wh : '1920*1080',
    quality : 'high',
    frame_rate : 25,
    bitrate : 4096,
    i_interval : 90
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn      | 0         | 通道 |
| idx       | 0         | 实时流序号: 主码流,子码流 |
| fmt       | 'h264'    | 编码格式: 'h264','h265' |
| rc_mode   | 'vbr'     | 定码流'cbr',变码流'vbr' |
| wh        | '1920*1080'| 宽高 |
| quality   | 'high'    | 图像质量: 'highest', 'higher', 'high','middle','low','lower', 'lowest' |
| frame_rate| 25        | 帧率[1,25](/秒) |
| bitrate   | 4096      | 码流比特率[128,6144](bps) |
| i_interval| 90        | I帧间隔[25,90](帧数) |

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


### 4. 获取实时视频流参数
* v1.0.2
* 获取默认实时流命令: 'default_stream'

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
    rc_mode : 'vbr',
    wh : '1920*1080',
    quality : 'hight',
    frame_rate : 25,
    bitrate : 4096,
    i_interval : 90,
    range : {
      fmt : {'h264', 'h265'},
      rc_mode : {'vbr', 'cbr'},
      wh : {'1920*1080', '1280*720'},
      quality : {'highest', 'higher', 'high','middle','low','lower', 'lowest'},
      frame_rate : {
        min : 1,
        max : 25
      },
      bitrate : {
        min : 256,
        max : 6144
      },
      i_interval : {
        min : 25,
        max : 90
      }
    }
  }
}
```

### 4. 设置图片流参数
* v1.0.2
* 请求

```javascript
{
  cmd : "set_stream_pic",
  llssid : "123456",
  llauth : "123456",
  set_stream_pic : {
    chnn : 0,
    idx : 64,
    fmt : 'jpeg',
    wh : '4000*3000',
    quality : 'high',
    interval_ms : 333
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn      | 0         | 通道 |
| idx       | 64        | 图片流1, 图片流2 |
| fmt       | 'jpeg'    | 编码格式: 'jpeg' |
| wh        | '4000*3000'| 宽高 |
| quality   | 'high'    | 图像质量 |
| interval_ms | 333      | 图片流间隔(毫秒) |

* 回复

```javascript
{
  cmd : "set_stream_pic",
  set_stream_pic : {
    code : 0
  }
}
```

### 5. 获取图片流参数
* v1.0.2
* 获取默认实时流命令: 'default_stream_pic'

* 请求

```javascript
{
  cmd : "stream_pic",
  llssid : "123456",
  llauth : "123456",
  stream_pic : {
    chnn : 0,
    idx : 64
  }
}
```

|   参数    |   默认值   |   备注    |
|:---------:|:--------- |:--------- |
| chnn      | 0         | 通道 |
| idx       | 64        | 图片流1,图片流2 |


* 回复

```javascript
{
  cmd : "stream_pic",
  stream_pic : {
    code : 0,
    chnn : 0,
    idx : 64,
    fmt : 'jpeg',
    wh : '4000*3000',
    quality : 'high',
    interval_ms : 333,
    range : {
      fmt : 'jpeg',
      wh : {'4000*3000', '1920*1080'},
      quality : {'highest', 'higher', 'high','middle','low','lower', 'lowest'},
      interval_ms : {
        min : 333,
        max : 3600000
      }
    }
  }
}
```
