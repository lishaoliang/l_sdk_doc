## 升级操作

### 1. 升级系统
* 暂不支持网络升级
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'upgrade',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : 'upgrade',
  upgrade : {
    code : 0
  }
}
```
