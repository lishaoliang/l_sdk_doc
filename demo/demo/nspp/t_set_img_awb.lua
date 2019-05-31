--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/5/20
--
-- @brief	测试设置图像白平衡
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/image.md
--]]
local tostring = tostring
local string = require("string")
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

-- 获取白平衡设置
local t_get_img_awb = function (id, chnn)
		local req = {
		cmd = 'img_awb',
		--llssid = '123456',
		--llauth = '123456',
		img_awb = {
			chnn = chnn	-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get img_awb,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	return ((obj or E).img_awb or E).awb
end


-- 获取当前镜头ISP的实时白平衡信息
local t_get_info_img_awb = function (id, chnn)
	local req = {
		cmd = 'info_img_awb',
		--llssid = '123456',
		--llauth = '123456',
		info_img_awb = {
			chnn = chnn		-- 0
		}
	}
	
	local ret, res = l_sdk.request(id, to_json(req))
	print('request get info_img_awb,ret=' .. ret, 'res='..res)

	local dec, obj = pcall(cjson.decode, res)
	
	local E = {}
	local b = ((obj or E).info_img_awb or E).b
	local gb = ((obj or E).info_img_awb or E).gb
	local gr = ((obj or E).info_img_awb or E).gr
	local r = ((obj or E).info_img_awb or E).r
	
	return b, gb, gr, r
end

-- 设置白平衡设置
local t_set_img_awb = function (id, chnn, awb, b, gb, gr, r)
	local req = {
		cmd = 'set_img_awb',
		--llssid = '123456',
		--llauth = '123456',
		set_img_awb = {
			chnn = chnn,		-- 0
			awb = awb,			-- 'auto', 'manual'
			b = b,				-- [0, 4095]
			gb = gb,			-- [0, 4095]
			gr = gr,			-- [0, 4095]
			r = r				-- [0, 4095]
		}
	}
	
	local txt_req = to_json(req)
	local ret, res = l_sdk.request(id, txt_req)
	
	print('request set_img_awb, awb = ' .. tostring(awb) .. ': req = ' .. txt_req)
	print('ret=' .. ret, 'res='..res)
end


local now_b, now_gb, now_gr, now_r = t_get_info_img_awb(id, 0)


local awb = t_get_img_awb(id, 0)
print('request,now img_awb = ' .. tostring(awb))


if 'auto' == awb then
	-- 使用随机值
	--t_set_img_awb(id, 0, 'manual', l_sys.rand(4096) - 1, l_sys.rand(4096) - 1, l_sys.rand(4096) - 1, l_sys.rand(4096) - 1)
	
	-- 使用实时白平衡信息,刚从服务端获取来的值
	t_set_img_awb(id, 0, 'manual', now_b, now_gb, now_gr, now_r)
	
	-- 使用实时白平衡信息,服务端自行完成
	--t_set_img_awb(id, 0, 'manual')
	
	-- 自定义的值, gb = gr
	--t_set_img_awb(id, 0, 'manual', 200, 2047, 2047, 1000)
	
	-- 缺失某项, 和不带 b gb gr r效果一样
	--t_set_img_awb(id, 0, 'manual', 200, 2047, nil, 1000)
else
	t_set_img_awb(id, 0, 'auto')
end


-- 休眠3S
l_sys.sleep(3000)


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
