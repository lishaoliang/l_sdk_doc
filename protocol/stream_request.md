## 媒体流

### 1. 请求媒体流

* 请求

```javascript
{
  cmd : "start_stream",
  llssid : "123456",
  llauth : "123456",
  start_stream : {
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
| md_id   | 0         | 媒体id: 用于区分同一个连接中同时请求多份流序号相同的码流; 由客户端决定 |

* 回复

```javascript
{
  cmd : "start_stream",
  start_stream : {
    code : 0
  }
}
```

* 备注
   1. [流序号idx说明](https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream_idx.md)
   2. 媒体md_id值由客户端决定, 取值范围[0 ~ 2^24]


### 2. 关闭媒体流

* 请求

```javascript
{
  cmd : "stop_stream",
  llssid : "123456",
  llauth : "123456",
  start_stream : {
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
| md_id   | 0         | 媒体id: 用于区分同一个连接中同时请求多份流序号相同的码流; 由客户端决定 |

* 回复

```javascript
{
  cmd : "stop_stream",
  stop_stream : {
    code : 0
  }
}
```
