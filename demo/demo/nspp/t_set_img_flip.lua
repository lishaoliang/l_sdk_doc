--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/5/28
--
-- @brief	测试设置图像垂直翻转
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/image.md
--]]
local tostring = tostring
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")


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

local t_get_img_flip = function (id, chnn)
		local req = {
		cmd = 'img_mirror_flip',
		--llssid = '123456',
		--llauth = '123456',
		img_mirror_flip = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get img_mirror_flip,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	return ((obj or E).img_mirror_flip or E).flip
end


local t_set_img_flip = function (id, chnn, flip)
	local req = {
		cmd = 'set_img_mirror_flip',
		--llssid = '123456',
		--llauth = '123456',
		set_img_mirror_flip = {
			chnn = chnn,		-- 0
			-- mirror = false,	-- true, false
			flip = flip			-- true, false
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request set_img_mirror_flip, flip=' .. tostring(flip) .. ',ret=' .. ret, 'res='..res)
end


local flip = t_get_img_flip(id, 0)
print('request,now flip = ' .. tostring(flip))


t_set_img_flip(id, 0, not flip)


-- 休眠3S
l_sys.sleep(3000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
