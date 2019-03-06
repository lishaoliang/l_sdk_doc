## 图像参数

* 图像部分约定范围[0-100], N=100
* 默认值50, 为通用环境下最优设定
* 如果协议约定值与实际设备对应不上, 由各设备自行处理映射关系


### 1. 设置图像参数

* 请求

```javascript
{
  cmd : 'set_image',
  llssid : '123456',
  llauth : '123456',
  set_image : {
    chnn : 0,
    bright : 50,
    contrast : 50,
    saturation : 50,
    hue : 50
  }
}
```

|   参数    |    类型   |   默认值  |   备注    |
|:---------:|:--------- |:--------- |:--------- |
| chnn      | 数值      | 0         | 通道 |
| bright    | 数值      | N/2       | 亮度[0, N] |
| contrast  | 数值      | N/2       | 对比度[0, N] |
| saturation| 数值      | N/2       | 饱和度[0, N] |
| hue       | 数值      | N/2       | 色度[0, N] |


* 回复

```javascript
{
  cmd : 'set_image',
  set_image : {
    code : 0
  }
}
```

### 2. 获取图像参数
* 获取默认图像参数: 'default_image'

* 请求

```javascript
{
  cmd : 'image',
  llssid : '123456',
  llauth : '123456',
  image : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'image',
  image : {
    code : 0,
    chnn : 0,
    bright : 50,
    contrast : 50,
    saturation : 50,
    hue : 50
  }
}
```

### 3. 设置图像宽动态

* 请求

```javascript
{
  cmd : 'set_img_wd',
  llssid : '123456',
  llauth : '123456',
  set_img_wd : {
    chnn : 0,
    enable : true,
    value : 50
  }
}
```

|   参数    |    类型   |   默认值  |   备注    |
|:---------:|:-------- |:--------- |:--------- |
| chnn      | 数值      | 0         | 通道 |
| enable    | 布尔      | true      | 是否使能宽动态 |
| value     | 数值      | N/2       | 宽动态精度值 |


* 回复

```javascript
{
  cmd : 'set_img_wd',
  set_img_wd : {
    code : 0
  }
}
```

### 4. 获取图像宽动态
* 获取默认图像宽动态: 'default_img_wd'

* 请求

```javascript
{
  cmd : 'img_wd',
  llssid : '123456',
  llauth : '123456',
  img_wd : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'img_wd',
  img_wd : {
    code : 0,
    chnn : 0,
    enable : true,
    value : 50
  }
}
```

### 5. 设置图像数字降噪

* 请求

```javascript
{
  cmd : 'set_img_dnr',
  llssid : '123456',
  llauth : '123456',
  set_img_dnr : {
    chnn : 0,
    dnr_type : 'none',
    value : 50
  }
}
```

|   参数    |    类型   |   默认值  |   备注    |
|:---------:|:-------- |:--------- |:--------- |
| chnn      | 数值      | 0         | 通道 |
| dnr_type  | 字符串    | 'none'    | 无降噪'none',普通降噪'normal' |
| value     | 数值      | N/2       | 普通降噪值 |


* 回复

```javascript
{
  cmd : 'set_img_dnr',
  set_img_dnr : {
    code : 0
  }
}
```

### 6. 获取图像数字降噪
* 获取默认图像数字降噪: 'default_img_dnr'

* 请求

```javascript
{
  cmd : 'img_dnr',
  llssid : '123456',
  llauth : '123456',
  img_dnr : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'img_dnr',
  img_dnr : {
    code : 0,
    chnn : 0,
    dnr_type : 'none',
    value : 50,
    range : {
      dnr_type : 'none'
    }
  }
}
```


### 7. 设置图像白平衡

* 请求

```javascript
{
  cmd : 'set_img_wb',
  llssid : '123456',
  llauth : '123456',
  set_img_wb : {
    chnn : 0,
    wb_type : {'none'}
  }
}
```

|   参数    |    类型   |   默认值  |   备注    |
|:---------:|:-------- |:--------- |:--------- |
| chnn      | 数值      | 0         | 通道 |
| wb_type   | 字符串    | 'none'    | 无白平衡'none' |

* 备注
  1. 白平衡类型
  2.


* 回复

```javascript
{
  cmd : 'set_img_wb',
  set_img_wb : {
    code : 0
  }
}
```

### 8. 获取图像白平衡
* 获取默认图像白平衡: 'default_img_wb'

* 请求

```javascript
{
  cmd : 'img_wb',
  llssid : '123456',
  llauth : '123456',
  img_wb : {
    chnn : 0,
  }
}
```

* 回复

```javascript
{
  cmd : 'img_wb',
  img_wb : {
    code : 0,
    chnn : 0,
    wb_type : 'none',
    range : {
      wb_type : {'none'}
    }
  }
}
```
