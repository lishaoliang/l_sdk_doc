## 2、批量协议请求

### 注意事项
* 命令请求有次序，服务端依照次序处理
* 批量协议请求最大个数 NA
* 批量请求排除命令: "login","logout"

### 参考示例1
* 请求不重复的协议字段

* 请求

```javascript
{
  cmd : "system,hello",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "system,hello",
  system : {
    code : 0,
    model : "wifi-ipc-3516a"
  },
  hello : {
    code : 0,
    msg : "welcome!"
  }
}
```

### 参考示例2
* 请求重复的协议字段

* 请求

```javascript
{
  cmd : "hello_0,hello_1,hello_2",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "hello_0,hello_1,hello_2",
  hello_0 : {
    code : 0,
    msg : "welcome!"
  },
  hello_1 : {
    code : 0,
    msg : "welcome!"
  },
  hello_2 : {
    code : 0,
    msg : "welcome!"
  }
}
```
