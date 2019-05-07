--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/04/15
--
-- @brief	使用HTTP登录
-- @author	李绍良
--]]

local curl = require("demo.curl")
local target = require("demo.target")
local to_json =  require("demo.to_json")


-- @brief 登录到设备
-- @param [in]  	ip[string]			设备ip
-- @param [in]		port[number]		端口
-- @param [in]		username[string]	用户名
-- @param [in]		passwd[string]		密码
-- @return err_id[number]	 0.成功; 非0.错误码
--	\n		login_id[number] 登录成功之后的登录id	
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--  \n 'err_id'错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
local h_login = function (ip, port, username, passwd)
	local req = {
		cmd = 'login',
		llssid = '123456',
		llauth = '123456',
		login = {
			username = username,
			passwd = passwd
		}
	}
	
	local json = to_json(req)	

	local ret, res = curl.post(ip, port, target.path, json)
	print(ret, res)
	
	return ret, res
end


h_login('192.168.1.247', 80, 'admin', '123456')

return h_login
