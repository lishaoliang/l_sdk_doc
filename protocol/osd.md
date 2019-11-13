## OSD设置


### 1. 设置OSD时间戳
* v1.1.1

* 请求

```javascript
{
  cmd : 'set_osd_timestamp',
  llssid : '123456',
  llauth : '123456',
  set_osd_timestamp : {
    chnn : 0,
    enable : false,
    format : 'YY-MM-DD HH:MM:SS.3',
    pos : 'right,top',
    font_size : 'middle',
  }
}
```

* 回复

```javascript
{
  cmd : 'set_osd_timestamp',
  set_osd_timestamp : {
    code : 0
  }
}
```

|  值域     | 类型        |   备注    |
|:---------:|:---------- |:--------- |
| code      | 数值(r)     | 错误码 |
| enable    | 布尔(rw)    | 是否使能NTP |
| format    | 字符串(rw)  | 日期时间格式 |
| pos       | 字符串(rw)  | 画面位置(x,y) |
| font_size | 字符串(rw)  | 相对的字体大小 |


### 2. 获取OSD时间戳
* v1.1.1

* 获取默认OSD时间戳: 'default_osd_timestamp'
* 请求

```javascript
{
  cmd : 'osd_timestamp',
  llssid : '123456',
  llauth : '123456',
  osd_timestamp : {
    chnn : 0,
  }
}
```

* 回复

```javascript
{
  cmd : 'osd_timestamp',
  osd_timestamp : {
    code : 0,
    chnn : 0,
    enable : false,
    format : 'YY-MM-DD HH:MM:SS.3',
    pos : 'right,top',
    font_size : 'middle',
    range {
      format : {
        'YY-MM-DD HH:MM:SS.3',
        'YY-MM-DD HH:MM:SS',
        'YY/MM/DD HH:MM:SS.3',
        'YY/MM/DD HH:MM:SS',

        'MM-DD-YY HH:MM:SS.3',
        'MM-DD-YY HH:MM:SS',
        'MM/DD/YY HH:MM:SS.3',
        'MM/DD/YY HH:MM:SS'
      },
      pos : {
        'right,top',
        'right,center',
        'right,bottom',
        'left,top',
        'left,center',
        'left,bottom',
        'center,top',
        'center,center',
        'center,bottom'
      },
      font_size : {
        'smallest',
        'smaller',       
        'small',
        'middle',
        'larg',
        'larger',
        'largest'
      }
    }
  }
}
```
