--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	测试设置码流参数
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

local set_stream_1080P = function (id, chnn, idx)
	local req = {
		cmd = 'set_stream',
		--llssid = '123456',	-- l_sdk自动将此域补充完成
		--llauth = '123456',	-- l_sdk自动将此域补充完成
		set_stream = {
			chnn = chnn,
			idx = idx,
			fmt = 'h264',
			rc_mode = 'cbr',	-- 'cbr', 'vbr'
			wh = '1920*1080',	-- '1920*1080','1280*720'
			--wh = '1280*720',
			quality = 'high',
			frame_rate = 25,	-- [1,25]
			bitrate = 6144,		-- [128, 6144] Kbps
			i_interval = 50		-- [25, 90]
		}
	}
	
	local json = to_json(req)
	--print('open stream:', json)

	local err, res = l_sdk.request(id, json)

	return err, res
end

local set_stream_720P = function (id, chnn, idx)
	local req = {
		cmd = 'set_stream',
		--llssid = '123456',	-- l_sdk自动将此域补充完成
		--llauth = '123456',	-- l_sdk自动将此域补充完成
		set_stream = {
			chnn = chnn,
			idx = idx,
			fmt = 'h264',
			rc_mode = 'cbr',	-- 'cbr', 'vbr'
			--wh = '1920*1080',	-- '1920*1080','1280*720'
			wh = '1280*720',	-- '1920*1080','1280*720'
			quality = 'high',
			frame_rate = 25,	-- [1,25]
			bitrate = 3096,		-- [128, 6144]
			i_interval = 50		-- [25, 90]
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

	local count = 0	
	while dlg:is_run() do			-- 窗口是否关闭		
		count = count + 1;
		if 60 < count then
			count = 0
		end
		
		if 0 == count then
			local ret , res = set_stream_1080P(id, chnn, idx)
			print('set_stream_1080P.ret='..ret, res)
		elseif 30 == count then
			local ret , res = set_stream_720P(id, chnn, idx)
			print('set_stream_720P.ret='..ret, res)
		end
		
		
		l_sys.sleep(1000)
	end
	dlg:close()
end

-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
