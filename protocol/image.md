## 9、图像参数

* 图像部分约定范围[0-100], N=100
* 默认值50, 为通用环境下最优设定
* 如果协议约定值与实际设备对应不上, 由各设备自行处理映射关系


### 1. 设置图像参数
* v1.0.2
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
* v1.0.2
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
* 不支持
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
* 不支持
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
* 不支持
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
* 不支持
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
      dnr_type : {'none', 'normal'}
    }
  }
}
```

### 7. 获取当前图像白平衡信息
* v1.0.10
* 获取当前镜头ISP的实时白平衡信息

* 请求

```javascript
{
  cmd : 'info_img_awb',
  llssid : '123456',
  llauth : '123456',
  info_img_awb : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'info_img_awb',
  info_img_awb : {
    code : 0,
    chnn : 0,
    b : 2047,
    gb : 2047,
    gr : 2047,
    r : 2047
  }
}
```

### 8. 设置图像白平衡
* v1.0.8
* 请求

```javascript
{
  cmd : 'set_img_awb',
  llssid : '123456',
  llauth : '123456',
  set_img_awb : {
    chnn : 0,
    awb : 'auto',
    b : 2047,
    gb : 2047,
    gr : 2047,
    r : 2047
  }
}
```

|   参数    |    类型   |   默认值  |   备注    |
|:---------:|:-------- |:--------- |:--------- |
| chnn      | 数值      | 0         | 通道 |
| awb       | 字符串    | 'auto'    | 自动白平衡'auto' |
| b         | 数值      | 2047      | B gain |
| gb        | 数值      | 2047      | Gb gain |
| gr        | 数值      | 2047      | Gr gain |
| r         | 数值      | 2047      | R gain |

* 回复

```javascript
{
  cmd : 'set_img_awb',
  set_img_awb : {
    code : 0
  }
}
```

* 当awb='manual', 不带[b, gb, gr, r]参数或缺失其中任何一项, 表示使用实时白平衡信息,
* 当awb='manual', 带[b, gb, gr, r]完整参数, 表示使用这些白平衡参数
* 当awb='auto', [b, gb, gr, r]等参数无效


### 9. 获取图像白平衡
* v1.0.8
* 获取默认图像白平衡: 'default_img_awb'

* 请求

```javascript
{
  cmd : 'img_awb',
  llssid : '123456',
  llauth : '123456',
  img_awb : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'img_awb',
  img_awb : {
    code : 0,
    chnn : 0,
    awb : 'auto',
    b : 2047,
    gb : 2047,
    gr : 2047,
    r : 2047,
    range : {
      awb : {'auto', 'manual'}
      b : {
        min : 0,
        max : 4095
      },
      gb : {
        min : 0,
        max : 4095
      },
      gr : {
        min : 0,
        max : 4095
      },
      r : {
        min : 0,
        max : 4095
      }
    }
  }
}
```

* awb = 'auto' : 自动白平衡
* awb = 'manual' : 手动白平衡, 手动设置 'b', 'gb', 'gr', 'r'


### 10. 设置图像旋转
* v1.0.8
* 请求

```javascript
{
  cmd : 'set_img_rotate',
  llssid : '123456',
  llauth : '123456',
  set_img_rotate : {
    chnn : 0,
    rotate : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'set_img_rotate',
  set_img_rotate : {
    code : 0
  }
}
```

|   型号    |    芯片   |   是否支持   |
|:---------:|:-------- |:--------- |
|           | Hi3519   | 支持 |
|           | Hi3516A  | 不支持 |


### 11. 获取图像旋转
* v1.0.8
* 获取默认图像旋转: 'default_img_rotate'
* 请求

```javascript
{
  cmd : 'img_rotate',
  llssid : '123456',
  llauth : '123456',
  img_rotate : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'img_rotate',
  img_rotate : {
    code : 0,
    chnn : 0,
    rotate : 0,
    range : {
      rotate : {0, 180}
    }
  }
}
```


### 12. 设置图像的镜像翻转
* v1.0.9
* 请求

```javascript
{
  cmd : 'set_img_mirror_flip',
  llssid : '123456',
  llauth : '123456',
  set_img_mirror_flip : {
    chnn : 0,
    flip : true,
    mirror : false
  }
}
```

|   参数    |    类型   |   默认值  |   备注    |
|:---------:|:-------- |:--------- |:--------- |
| chnn      | 数值     | 0         | 通道 |
| flip      | 布尔     | true      | 垂直翻转 |
| mirror    | 布尔     | false     | 水平镜像 |

* 回复

```javascript
{
  cmd : 'set_img_mirror_flip',
  set_img_mirror_flip : {
    code : 0
  }
}
```


### 13. 获取图像的镜像翻转
* v1.0.9
* 获取默认 图像的镜像翻转: 'default_img_mirror_flip'
* 请求

```javascript
{
  cmd : 'img_mirror_flip',
  llssid : '123456',
  llauth : '123456',
  img_mirror_flip : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'img_mirror_flip',
  img_mirror_flip : {
    code : 0,
    chnn : 0,
    flip : true,
    mirror : false
  }
}
```


### 14. 设置图像曝光
* v1.0.13
* 请求

```javascript
{
  cmd : 'set_img_exposure',
  llssid : '123456',
  llauth : '123456',
  set_img_exposure : {
    chnn : 0,
    compensation : 56
  }
}
```

|   参数       |   类型   |   默认值  |   备注    |
|:------------:|:-------- |:--------- |:--------- |
| chnn         | 数值     | 0         | 通道 |
| compensation | 数值     | 56        | 自动曝光调整时的目标亮度[0,255] |

* 回复

```javascript
{
  cmd : 'set_img_exposure',
  set_img_exposure : {
    code : 0
  }
}
```


### 15. 获取图像曝光
* v1.0.13
* 获取默认图像曝光: 'default_img_exposure'
* 请求

```javascript
{
  cmd : 'img_exposure',
  llssid : '123456',
  llauth : '123456',
  img_exposure : {
    chnn : 0
  }
}
```

* 回复

```javascript
{
  cmd : 'img_exposure',
  img_exposure : {
    code : 0,
    chnn : 0,
    compensation : 56,
    range : {
      compensation : {
        min : 0,
        max : 255
      }
    }
  }
}
```
