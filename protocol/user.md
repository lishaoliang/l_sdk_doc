## 5、账户体系

### 1. 超级管理员账户
* 固定为: 'admin'
* 默认密码: '123456'


### 2. 添加用户
* 不支持
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'user_add',
  llssid : '123456',
  llauth : '123456',
  user_add : {
    name : 'xxx',
    passwd : 'xxx',
    type : 'operator',
    auth : {
      cfg : true,
      ctrl : true,
      ctrl_sys : false
    },
    range : {
      type : {'operator', 'user'}
    }
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| name      | 字符串(rw)  | 用户名称 |
| passwd    | 字符串(rw)  | 用户密码 |
| type      | 字符串(rw)  | 用户类型 |

* 备注
  1. 'administrators' 管理员, 仅限'admin'用户
  2. 'operator' 操作员
  3. 'user' 普通用户

* 回复

```javascript
{
  cmd : 'user_add',
  user_add : {
    code : 0
  }
}
```

### 3. 删除用户
* 不支持
* 仅限'admin'
* 'admin'用户不可被删除
* 请求

```javascript
{
  cmd : 'user_remove',
  llssid : '123456',
  llauth : '123456',
  user_remove : {
    name : 'xxx'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| name      | 字符串(rw)  | 用户名称 |

* 回复

```javascript
{
  cmd : 'remove_user',
  remove_user : {
    code : 0
  }
}
```

### 4. 修改用户权限及密码
* 不支持
* 仅限'admin'

* 请求

```javascript
{
  cmd : 'user_modify',
  llssid : '123456',
  llauth : '123456',
  user_modify : {
    name : 'xxx',
    passwd : 'xxx',
    type : 'operator',
    auth : {
      cfg : true,
      ctrl : true,
      ctrl_sys : false
    }
  }
}
```

* 回复

```javascript
{
  cmd : 'user_modify',
  user_modify : {
    code : 0
  }
}
```

### 5. 获取所有用户信息
* 不支持
* 仅限'admin'
* 仅供'admin'来管理用户

* 请求

```javascript
{
  cmd : 'user_all',
  llssid : '123456',
  llauth : '123456'
}
```


* 回复

```javascript
{
  cmd : 'user_all',
  user_all : {
    code : 0,
    users : {
      {
        name : 'xxx',
        passwd : 'xxx',
        type : 'operator',
        auth : {
          cfg : true,
          ctrl : true,
          ctrl_sys : false
        }
        range : {
          type : {'operator', 'user'}
        }
      },
      {...},
      {...}
    }
  }
}
```

### 6. 修改密码
* 不支持
* 各个用户可以修改各自密码
* 只有'admin'可以修改所有用户密码

* 请求

```javascript
{
  cmd : 'user_modify_pwd',
  llssid : '123456',
  llauth : '123456',
  user_modify_pwd : {
    name : 'xxx',
    passwd : 'xxx',
    old_passwd : 'xxx'
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| name      | 字符串(rw)  | 用户名称  |
| passwd    | 字符串(rw)  | 用户新密码  |
| old_passwd| 字符串(rw)  | 用户旧名称  |


* 回复

```javascript
{
  cmd : 'user_modify_pwd',
  user_modify_pwd : {
    code : 0
  }
}
```

### 7. 获取用户信息
* 不支持
* 各个用户可以获取自身信息
* 仅供读取

* 请求

```javascript
{
  cmd : 'user_info',
  llssid : '123456',
  llauth : '123456'
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| name      | 字符串(rw)  | 用户名称 |
| passwd    | 字符串(rw)  | 用户密码 |
| type      | 字符串(rw)  | 用户类型 |

* 备注
  1. 'administrators' 管理员, 仅限'admin'用户
  2. 'operator' 操作员
  3. 'user' 普通用户

* 回复

```javascript
{
  cmd : 'user_info',
  user_info : {
    code : 0,
    name : 'xxx',
    passwd : 'xxx',
    type : 'operator',
    auth : {
      cfg : true,
      ctrl : true,
      ctrl_sys : false
    }
    range : {
      type : {'operator', 'user'}
    }
  }
}
```

### 8. 获取在线用户信息
* 不支持
* 请求

```javascript
{
  cmd : 'user_online',
  llssid : '123456',
  llauth : '123456'
}
```

* 回复

```javascript
{
  cmd : 'user_online',
  user_online : {
    code : 0,
    users : {
      { name : 'xxx', type : 'operator' },
      {...},
      {...}
    }
  }
}
```
