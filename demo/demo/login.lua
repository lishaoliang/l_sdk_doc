--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	登录到设备
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc
--]]
local l_sdk = require("l_sdk")
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
local login = function (ip, port, username, passwd)
	local req = {
		ip = ip,
		port = port,
		
		login = {
			username = username,
			passwd = passwd
		}
	}
	
	local json = to_json(req)
	--print('login json:', json)
	
	local err_id, login_id = l_sdk.login(json)
	
	return err_id, login_id
end

return login
