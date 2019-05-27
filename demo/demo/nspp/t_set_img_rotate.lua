--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/5/20
--
-- @brief	测试设置图像镜像
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/image.md
--]]
local tostring = tostring
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson.safe")


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

local t_get_img_rotate = function (id, chnn)
		local req = {
		cmd = 'img_rotate',
		--llssid = '123456',
		--llauth = '123456',
		img_rotate = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get img_rotate,ret=' .. ret, 'res='..res)

	local dec = cjson.decode(res)
	
	local E = {}
	return ((dec or E).img_rotate or E).rotate
end


local t_set_img_rotate = function (id, chnn, rotate)
	local req = {
		cmd = 'set_img_rotate',
		--llssid = '123456',
		--llauth = '123456',
		set_img_rotate = {
			chnn = chnn,		-- 0
			rotate = rotate		-- 0, 180
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request set_img_rotate, rotate=' .. tostring(rotate) .. ',ret=' .. ret, 'res='..res)
end


local rotate = t_get_img_rotate(id, 0)
print('request,now rotate = ' .. tostring(rotate))

if 0 == rotate then
	rotate = 180
else
	rotate = 0
end

t_set_img_rotate(id, 0, rotate)


-- 休眠3S
l_sys.sleep(3000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
