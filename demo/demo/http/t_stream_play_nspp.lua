--[[
-- Copyright (c) 2019 �人˴������, All Rights Reserved
-- Created: 2019/12/25
--
-- @brief	(HTTP-NSPPЭ��)���Ի�ȡ����
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local conn_status = function (...)
	local req = {
		cmd = 'status_connect',
		status_connect = {}
	}

	for i, v in ipairs({...}) do
		if 'string' == type(v) then
			table.insert(req.status_connect, v)
		end
	end
	
	local ret, res = l_sdk.request(0, to_json(req))
	
	return ret, res
end


-- sdk��ʼ��
l_sdk.init('')


local chnn = 0
local idx = 0	-- 0.������, 1.������

-- '/luanspp/chnn0/idx0'
-- '/luanspp/chnn0/idx1'
local path = string.format('/luanspp/chnn%d/idx%d', chnn, idx)


-- ��¼���豸
local err, id = login(target.ip, target.port, target.username, target.passwd, 'http_nspp', 'GET', path)


-- ��ӡ��¼���
if 0 ~= err then
	print('http_nspp login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('http_nspp login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end


if 0 ~= err then
	
	-- ����3S
	l_sys.sleep(3000)
else	
	--  ���ò�����,��Ҫwin֧��Opengl2.0����
	local dlg = l_sdk.open_wnd()	-- �򿪴���
	dlg:bind(id, chnn, idx, 0)		-- �����ڰ󶨵���¼id, ͨ��, �����
	
	local cs_tc = 0
	while dlg:is_run() do			-- �����Ƿ�ر�
		cs_tc = cs_tc + 200
		if 3000 <= cs_tc then
			cs_tc = 0
			print(conn_status(tostring(id)))
		end
		
		l_sys.sleep(200)
	end
	
	dlg:close()
end

-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()