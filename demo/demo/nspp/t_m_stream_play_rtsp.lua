--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/11/21
--
-- @brief	(RTSPЭ��)����������; ���Ի�ȡ��·��, ������ʾһ·��
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

local m_stream = function (num, chnn, idx, path)
	local err = 0
	local id = 0
	for i = 1, num do
		-- ��¼���豸
		err, id = login_rtsp(target.ip, target.port, path, target.username, target.passwd)
		print('login_rtsp ret='..err .. ' id='..id)
		
		local ret, res = open_stream(id, chnn, idx)
		print('open stream ret='..ret .. ' res='..res)
	end
	
	return err, id -- �������һ����¼�����
end


-- sdk��ʼ��
l_sdk.init('')


-- �򿪶����
-- Ŀǰ���� Hi3519ƽ̨, ������������, 1G·����������. ����IPC������ȡ800Mbps��������
-- ��ÿ·6M, �������ȡ130-140·��
local count = 60


--  rtsp������: rtsp://admin:123456@192.168.1.247:80/chnn0/idx0
--  rtsp������: rtsp://admin:123456@192.168.1.247:80/chnn0/idx1
--  rtspĬ��������: rtsp://admin:123456@192.168.1.247:80

local chnn = 0
local idx = 0	-- 0.������, 1.������

-- '/chnn0/idx0'
-- '/chnn0/idx1'
local path = string.format('/chnn%d/idx%d', chnn, idx)


local err, id = m_stream(count, chnn, idx, path);

	
--  ���ò�����,��Ҫwin֧��Opengl2.0����
local dlg = l_sdk.open_wnd()	-- �򿪴���
dlg:bind(id, chnn, idx, 0)		-- �����ڰ󶨵���¼id, ͨ��, �����
while dlg:is_run() do			-- �����Ƿ�ر�
	l_sys.sleep(200)
end
dlg:close()


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
