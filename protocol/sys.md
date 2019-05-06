## 11、系统控制

### 1. 重启系统
* 不支持
* 请求

```javascript
{
  cmd : "ctrl_reboot",
  llssid : "123456",
  llauth : "123456"
}
```

* 回复

```javascript
{
  cmd : "ctrl_reboot",
  ctrl_reboot : {
    code : 0
  }
}
```
