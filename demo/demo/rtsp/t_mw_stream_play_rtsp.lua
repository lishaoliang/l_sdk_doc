--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/11/21
--
-- @brief	(RTSP协议)测试多路解码显示
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local m_stream = function (num, ips, path)
	local ids = {}
	local dlgs = {}
	
	for i = 1, num do
		-- 登录到设备
		local ip = ips[i]
		local err, id = login(target.ip, target.port, target.username, target.passwd, 'rtsp', nil, path)
		print('login rtsp ret='..err .. ' id='..id)
		
		local dlg = l_sdk.open_wnd(100 + id, 400, 225, 'index : ' .. tostring(i) .. ' @' .. ip)	-- 打开窗口
		dlg:bind(id, 0, 0, 0)		-- 将窗口绑定到登录id, 通道, 流序号
		
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


--  rtsp主码流: rtsp://admin:123456@192.168.1.247:80/chnn0/idx0
--  rtsp子码流: rtsp://admin:123456@192.168.1.247:80/chnn0/idx1
--  rtsp默认子码流: rtsp://admin:123456@192.168.1.247:80

local chnn = 0
local idx = 1	-- 0.主码流, 1.子码流

-- '/chnn0/idx0'
-- '/chnn0/idx1'
local path = string.format('/chnn%d/idx%d', chnn, idx)


-- 对于rtsp协议而言, 并没有通道/流序号区分
-- 具体是哪个流, 取决于path参数
local ids, dlgs = m_stream(count, ips, path);


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
