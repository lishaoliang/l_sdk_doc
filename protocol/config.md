## 10、配置操作

### 1. 导出配置
* 不支持
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'cfg_export',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : 'cfg_export',
  cfg_export : {
    code : 0,
    text : 'xxxx'
  }
}
```

### 2. 导入配置
* 不支持
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'cfg_inport',
  llssid : '123456',
  llauth : '123456'
  cfg_inport : {
    text : 'xxxx'
  }
}
```

* 回复

```javascript
{
  cmd : 'cfg_inport',
  cfg_inport : {
    code : 0
  }
}
```

### 3. 恢复基础默认配置
* 不支持
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'cfg_default',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : 'cfg_default',
  cfg_default : {
    code : 0
  }
}
```

* 备注: 恢复的配置项目包含
  * 码流部分配置


### 4. 恢复绝大部分默认配置
* 不支持
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'cfg_default_all',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : 'cfg_default_all',
  cfg_default_all : {
    code : 0
  }
}
```

* 备注: 不恢复的配置项目包含
  * 'admin'用户的密码
