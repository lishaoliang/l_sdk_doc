--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/7/1
--
-- @brief	测试多路解码显示
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local set_stream = function (id, chnn, idx)
	local req = {
		cmd = 'set_stream',
		set_stream = {
			chnn = chnn,
			idx = idx,
			fmt = 'h264',
			rc_mode = 'cbr',	-- 'cbr', 'vbr'
			wh = '640*360',		-- '1920*1080','1280*720'
			quality = 'high',
			frame_rate = 25,	-- [1,25]
			bitrate = 256,		-- [128, 6144]
			i_interval = 75		-- [25, 90]
		}
	}
	
	local json = to_json(req)
	--print('open stream:', json)

	local err, res = l_sdk.request(id, json)

	return err, res
end


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

local m_stream = function (num, ips, chnn, idx)
	local ids = {}
	local dlgs = {}
	
	for i = 1, num do
		-- 登录到设备
		local ip = ips[i]
		local err, id = login(ip, target.port, target.username, target.passwd)
		print('login ret='..err .. ' id='..id)

		set_stream(id, chnn, idx)
		
		local ret, res = open_stream(id, chnn, idx)
		print('open stream ret='..ret .. ' res='..res)
		
		local dlg = l_sdk.open_wnd(100 + id, 400, 225, 'index : ' .. tostring(i) .. ' @' .. ip)	-- 打开窗口
		dlg:bind(id, chnn, idx, 0)		-- 将窗口绑定到登录id, 通道, 流序号
		
		table.insert(ids, id)
		table.insert(dlgs, dlg)
		
		l_sys.sleep(100)
	end
	
	return ids, dlgs
end


-- sdk初始化
l_sdk.init('')


-- 打开多个流
local count = 16

-- 使用同一个IP
local ips = {}
for i = 1, count do
	table.insert(ips, target.ip)
end

-- 使用不同的IP
--local ips = {'192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218',
--			 '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218',
--			 '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218',
--			 '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218'}


local chnn = 0
local idx = 1		-- 主码流0, 子码流1

local ids, dlgs = m_stream(count, ips, chnn, idx);


-- 检查窗口是否关闭
while true do
	local run = false
	for i, dlg in pairs(dlgs) do
		if dlg:is_run() then
			run = true
		end
	end

	if run then
		l_sys.sleep(200)
	else
		break
	end
end


-- 关闭所有窗口
for i, dlg in pairs(dlgs) do
	dlg:close()
end

-- 登出
for i, id in pairs(ids) do
	l_sdk.logout(id)
end


-- sdk退出
l_sdk.quit()
