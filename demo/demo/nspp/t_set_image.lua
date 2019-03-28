--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	测试设置图像参数
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local open_stream = function (id, chnn, idx)
	local req = {
		cmd = 'open_stream',
		--llssid = '123456',	-- l_sdk自动将此域补充完成
		--llauth = '123456',	-- l_sdk自动将此域补充完成
		open_stream = {
			chnn = chnn,
			idx = idx
		}
	}
	
	local json = to_json(req)
	--print('open stream:', json)

	local err, res = l_sdk.request(id, json)

	return err, res
end

local set_image = function (id, chnn, bright, contrast, saturation, hue)
	local req = {
		cmd = 'set_image',
		--llssid = '123456',	-- l_sdk自动将此域补充完成
		--llauth = '123456',	-- l_sdk自动将此域补充完成
		set_image = {
			chnn = chnn,
			bright = bright,
			contrast = contrast,
			saturation = saturation,
			hue = hue
		}
	}
	
	local json = to_json(req)
	--print('open stream:', json)

	local err, res = l_sdk.request(id, json)

	return err, res
end


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
local idx = 0

local err, res = open_stream(id, chnn, idx);
if 0 ~= err then
	print('open stream ok!err='..err)
	
	-- 休眠3S
	l_sys.sleep(3000)
else
	print('open stream ok!res='..res)
	
	--  内置播放器,需要win支持Opengl2.0以上
	local dlg = l_sdk.open_wnd()	-- 打开窗口
	dlg:bind(id, chnn, idx, 0)		-- 将窗口绑定到登录id, 通道, 流序号
	
	while dlg:is_run() do			-- 窗口是否关闭

		local bright = l_sys.rand(100)
		local contrast = l_sys.rand(100)
		local saturation = l_sys.rand(100)
		local hue = l_sys.rand(100)
	
		local ret, res = set_image(id, chnn, bright, contrast, saturation, hue);
		print('set image,ret='..ret, 'res='..res, 'bcsh='..bright..','..contrast..','..saturation..','..hue)
		
		l_sys.sleep(100)
	end
	dlg:close()
end

-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
