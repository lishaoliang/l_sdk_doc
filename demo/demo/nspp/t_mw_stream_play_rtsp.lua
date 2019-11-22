--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/11/21
--
-- @brief	(RTSPЭ��)���Զ�·������ʾ
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login_rtsp = require("demo.login_rtsp")

local open_stream = function (id, chnn, idx)
	local req = {
		cmd = 'open_stream',
		--llssid = '123456',	-- l_sdk�Զ������򲹳����
		--llauth = '123456',	-- l_sdk�Զ������򲹳����
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

local m_stream = function (num, ips, chnn, idx, path)
	local ids = {}
	local dlgs = {}
	
	for i = 1, num do
		-- ��¼���豸
		local ip = ips[i]
		local err, id = login_rtsp(ip, target.port, path, target.username, target.passwd)
		print('login_rtsp ret='..err .. ' id='..id)
		
		local ret, res = open_stream(id, chnn, idx)
		print('open stream ret='..ret .. ' res='..res)
		
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

local rtsp_id = function (idx)
	if 0 ~= idx then
		return 0 -- ������ rtsp0
	end
	
	return 1 -- ������ rtsp1
end

-- ������: '/chnn=0&id=1'
-- ������: '/chnn=0&id=0'
local path = string.format('/chnn=%d&id=%d', chnn, rtsp_id(idx))


-- ����rtspЭ�����, ��û��ͨ��/���������
-- �������ĸ���, ȡ����path����
local ids, dlgs = m_stream(count, ips, 0, 0, path);


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
