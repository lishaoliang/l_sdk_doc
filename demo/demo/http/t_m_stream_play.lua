--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/12/23
--
-- @brief	(HTTP-NSPPЭ��)����������; ���Ի�ȡ��·��, ������ʾһ·��
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local m_stream = function (num, chnn, idx, path)
	local err = 0
	local id = 0
	for i = 1, num do
		-- ��¼���豸
		err, id = login(target.ip, target.port, target.username, target.passwd, 'http_nspp', 'GET', path)
		print('http_nspp login ret='..err .. ' id='..id)
	end
	
	return err, id -- �������һ����¼�����
end


-- sdk��ʼ��
l_sdk.init('')


-- �򿪶����
-- Ŀǰ���� Hi3519ƽ̨, ������������, 1G·����������. ����IPC������ȡ800Mbps��������
-- ��ÿ·6M, �������ȡ130-140·��
local count = 60

local chnn = 0
local idx = 0

-- '/luanspp/chnn0/idx0'
-- '/luanspp/chnn0/idx1'
local path = string.format('/luanspp/chnn%d/idx%d', chnn, idx)

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
