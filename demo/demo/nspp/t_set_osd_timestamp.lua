--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/11/13
--
-- @brief	测试设置OSD时间戳
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/osd.md
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

local osd_timestamp = {
	cmd = 'set_osd_timestamp',
	--llssid = '123456',
	--llauth = '123456',
	set_osd_timestamp = {
		chnn = 0,
		enable = false,
		format = 'YY-MM-DD HH:MM:SS.3',
		pos = 'right,top',
		font_size = 'middle'
	}
}

local ret, res = l_sdk.request(id, to_json(osd_timestamp))
print('request set_osd_timestamp, ret='..ret, 'res='..res)


-- 休眠3S
l_sys.sleep(3000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
