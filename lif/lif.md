## 1、本地协议接口

### 1. 概述

* 相机本地UI开发
* 二次扩展开发
* 仅支持单用户登录
* 支持除媒体流之外的其他所有标准网络协议
* 更多支持项

```
    本地协议指通过unix本地端口在本机上进行的网络通信,用以操控相机,比标准网络协议拥有更多的支持项。
```

### 2. 函数'l_lif_init'
* 功能：初始化SDK所有模块
* 必须在使用所有SDK接口之前调用
* 暂不支持自定义配置，参数p_config=""即可

* 原型

```
int l_lif_init(const char* p_config);
```

* 参数

```
/// @param [in] *p_config json格式的sdk初始配置信息
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```

### 3. 函数'l_lif_quit'
* 功能：软件结束时，退出SDK，释放资源
* 必须在使用完毕后，再调用此接口

* 原型

```
void l_lif_quit();
```


### 4. 函数'l_lif_login'
* 功能：登入

* 原型

```
int l_lif_login(const char* p_param);
```

* 参数

```
/// @param [in] *p_param  登录参数

示例1：相机登入到其他设备
p_param = {
  cmd : 'login',  
  protocol : 'nspp',
  ip : '192.168.1.247',
  port : 80,
  login : {
    username : 'admin',
    passwd : '123456'
  }
}

示例2：相机登入到本机本地
p_param = {
  cmd : 'login',
  protocol : 'nspp_local',
  path : '/nfsmem/socket.ui',
  login : {
    username : 'admin',
    passwd : '123456'
  }
}
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```


### 5. 函数'l_lif_logout'
* 功能：登出

* 原型

```
int l_lif_logout();
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```


### 6. 函数'l_lif_request'
* 功能：登录后，向设备发起请求

* 原型

```
int l_lif_request(int id, const char* p_req, char** p_res);
```

* 参数

```
/// @param [in]  *p_req   请求json信息
/// @param [out] **p_res  如果请求成功,则为设备回复的json信息

p_param = {
  cmd : 'set_ipv4'
  set_ipv4 : {
    dhcp : false,
		ip : '192.168.3.150',
		netmask : '255.255.255.0',
		gateway : '192.168.3.1',
		dns1 : '',
		dns2 : ''
  }
}

p_res = {
  cmd : 'set_ipv4',
  set_ipv4 : {
    code : 0
  }
}
```

* 返回值

```
/// @return int 0.成功; 非0.错误码
/// @note 错误码参见SDK错误码
```

* 注意

```
返回值0，仅仅表示从服务端取到回复结果
命令是否成功执行, 还需要看回复的'code'值
输出的内存p_res, 需要使用函数l_lif_free释放
```

### 7. 函数'l_lif_free'
* 功能：释放中间字符串内存

* 原型

```
void l_lif_free(char* p_res);
```

* 参数

```
/// @param [in]  *p_res   sdk输出的字符串
```

### 8. Lua接口支持

```
--[[
-- Copyright(c) 2019, 武汉舜立软件 All Rights Reserved
-- Created: 2019/11/15
--
-- @file    libl_lif.so
-- @brief   本地协议接口; 本文件模拟描述libl_lif.so导出lua接口类
-- @version 0.1
-- @author  李绍良
--]]

local l_lif = {}



-- @brief 初始化sdk
-- @param [in] cfg[string]	json字符串
-- @return [number] 0.成功; 非0.错误码
l_lif.init = function (cfg)
	return 0
end


-- @brief 退出sdk
l_lif.quit = function ()

end


-- @brief 登录设备
-- @param [in] param[string]	json字符串
-- @return [number] err			错误码
l_lif.login = function (param)
	return err
end


-- @brief 登出设备
-- @return [number] err 错误码
l_lif.logout = function ()
	return err
end


-- @brief 请求数据
-- @param [in] str_req[string]	请求json字符串
-- @return err[number] 错误码
-- @return str_res[string] err=0时,从服务端回复的数据
l_lif.request = function (str_req)
	return err, str_res
end


return l_lif
```


### 9. Lua示例

* 注意: 本示例需要在相机串口中执行 ./llua ./xxx.lua

```
local l_sys = require("l_sys")
local l_lif = require("l_lif")
local cjson = require("cjson.safe")

-- @brief 将lua的table转换为json文本
-- @param [in] o[table] lua的table
-- @return [string] json字符串
local to_json = function (o)
	local t = type(o)

	if 'string' == t then
		return o
	elseif 'table' == t then
		local txt = cjson.encode(o)
		return txt
	else
		assert(false)
	end

	return '{}'
end

-- 初始化
l_lif.init()

-- 请求登录协议
local req_login ={
	cmd = 'login',
	--llssid = '123456',
	--llauth = '123456',
	protocol = 'nspp_local',
	path = '/nfsmem/socket.ui',
	login = {
		username = 'admin',
		passwd = '123456'
	}
}

-- 打印请求登录结果
print('req login:', l_lif.login(cjson.encode(req_login)))


-- 请求设备名称
local req_name = {
	cmd = 'name, default_name'
}

local ret, res = l_lif.request(to_json(req_name))
print('request name, ret='..ret, 'res='..res)


-- 请求系统信息
local req_system = {
	cmd = 'system'
}

local ret, res = l_lif.request(to_json(req_system))
print('request system, ret='..ret, 'res='..res)

l_sys.sleep(3000)

local ret, res = l_lif.request(to_json(req_system))
print('request system, ret='..ret, 'res='..res)

-- 登出
l_lif.logout()

-- 退出
l_lif.quit()
```
