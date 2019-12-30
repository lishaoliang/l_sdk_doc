--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/12/26
--
-- @brief	(HTTP-NSPPЭ��)���Զ�·������ʾ
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local m_stream = function (num, ips, chnn, idx, path)
	local ids = {}
	local dlgs = {}
	
	for i = 1, num do
		-- ��¼���豸
		local ip = ips[i]
		local err, id = login(ip, target.port, target.username, target.passwd, 'http_nspp', 'GET', path)
		print('http_nspp login ret='..err .. ' id='..id)
		
		local dlg = l_sdk.open_wnd(100 + id, 400, 225, 'index : ' .. tostring(i) .. ' @' .. ip)	-- �򿪴���
		dlg:bind(id, chnn, idx, 0)		-- �����ڰ󶨵���¼id, ͨ��, �����
		
		table.insert(ids, id)
		table.insert(dlgs, dlg)
		
		l_sys.sleep(100)
	end
	
	return ids, dlgs
end


-- sdk��ʼ��
l_sdk.init('')


-- �򿪶����
local count = 16

-- ʹ��ͬһ��IP
local ips = {}
for i = 1, count do
	table.insert(ips, target.ip)
end

-- ʹ�ò�ͬ��IP
--local ips = {'192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218',
--			 '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218',
--			 '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218',
--			 '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218', '192.168.1.218'}


local chnn = 0
local idx = 1		-- ������0, ������1

-- '/luanspp/chnn0/idx0'
-- '/luanspp/chnn0/idx1'
local path = string.format('/luanspp/chnn%d/idx%d', chnn, idx)

local ids, dlgs = m_stream(count, ips, chnn, idx, path);


-- ��鴰���Ƿ�ر�
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


-- �ر����д���
for i, dlg in pairs(dlgs) do
	dlg:close()
end

-- �ǳ�
for i, id in pairs(ids) do
	l_sdk.logout(id)
end


-- sdk�˳�
l_sdk.quit()
