--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	测试设置图片流
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/net.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


-- sdk初始化
l_sdk.init('')


-- 登录到设备
local err, id = login(target.ip, target.port, target.username, target.passwd)


-- 打印登录结果
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end


local chnn = 0
local idx = 64	--图片流1


local stream_pic = {
	cmd = 'stream_pic',
	--llssid = '123456',
	--llauth = '123456',
	stream_pic = {
		chnn = chnn,
		idx = idx
  }
}


local set_stream_pic = {
	cmd = 'set_stream_pic',
	--llssid = '123456',
	--llauth = '123456',
	set_stream_pic = {
		chnn = chnn,
		idx = idx,
		fmt = 'jpeg',
		wh = '4000*3000',
		quality = 'high',
		interval_ms = 333
	}
}

local ret, res = l_sdk.request(id, to_json(stream_pic))
print('request get stream_pic, ret='..ret, 'res='..res)


local ret, res = l_sdk.request(id, to_json(set_stream_pic))
print('request set stream_pic, ret='..ret, 'res='..res)


-- 休眠3S
l_sys.sleep(3000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
