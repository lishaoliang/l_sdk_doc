## 五、状态查询接口
* 使用函数l_sdk_request(0, req, res)

### 1. 连接状态
* 查看连接是否断开

* 请求

```javascript
{
  cmd : 'status_connect',
  status_connect : {
    '1000','1001','1002'
  }
}
```

* 回复

```javascript
{
  cmd : 'status_connect',
  status_connect : {
    code : 0,
    '1000' : 'none',
    '1001' : 'doing',
    '1002' : 'doing'
  }
}
```

* 状态为 'doing',表示连接正常
* 状态为 'none',表示非连接状态
