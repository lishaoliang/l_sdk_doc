--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	测试设置无线为 sta 模式
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

local set_sta = {
	cmd = 'set_wireless',
	--llssid = '123456',
	--llauth = '123456',
	set_wireless = {
		type = 'sta', -- 'ap' 'sta'
		net = '5g', -- '2.4g' '5g'
		ssid = target.wifi_ssid, --'HUAWEI-7NLNPF_5G',
		passwd = target.wifi_passwd, --'qwertyuiop1234567890',
		enc = 'wpa2 psk'
	}
}

local ret, res = l_sdk.request(id, to_json(set_sta))
print('request set_wireless to sta, ret='..ret, 'res='..res)


-- 休眠3S
l_sys.sleep(3000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
