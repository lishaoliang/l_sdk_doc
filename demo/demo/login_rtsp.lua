--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/11/20
--
-- @brief	使用rtsp协议登录到设备
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc
--]]
local l_sdk = require("l_sdk")
local to_json =  require("demo.to_json")


-- @brief 使用rtsp协议登录到设备
-- @param [in]  	ip[string]			设备ip
-- @param [in]		port[number]		端口
-- @param [in]		path[string]		请求路径
-- @param [in]		username[string]	用户名
-- @param [in]		passwd[string]		密码
-- @return err_id[number]	 0.成功; 非0.错误码
--	\n		login_id[number] 登录成功之后的登录id	
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--  \n 'err_id'错误码: https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net_err.md
-- @note
--  rtsp主码流: rtsp://admin:123456@192.168.1.247:80/chnn0/idx0
--  rtsp子码流: rtsp://admin:123456@192.168.1.247:80/chnn0/idx1
--  rtsp默认子码流: rtsp://admin:123456@192.168.1.247:80
local login_rtsp = function (ip, port, path, username, passwd)
	local req = {
		protocol = 'rtsp',
		path = path, -- '/chnn0/idx0'
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

return login_rtsp
