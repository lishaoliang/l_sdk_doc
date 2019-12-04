--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/11/20
--
-- @brief	����ʹ��RTSPЭ�鲥������
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local string = require("string")
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

	local ret, res = l_sdk.request(id, json)

	return ret, res
end

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

--print(conn_status('1000', '1001', '1002'))


--  rtsp������: rtsp://admin:123456@192.168.1.247:80/chnn0/idx0
--  rtsp������: rtsp://admin:123456@192.168.1.247:80/chnn0/idx1
--  rtspĬ��������: rtsp://admin:123456@192.168.1.247:80

local chnn = 0
local idx = 0	-- 0.������, 1.������

-- '/chnn0/idx0'
-- '/chnn0/idx1'
local path = string.format('/chnn%d/idx%d', chnn, idx)


-- ��¼���豸
local err, id = login_rtsp(target.ip, target.port, path, target.username, target.passwd)


-- ��ӡ��¼���
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end

local err, res = open_stream(id, chnn, idx);
if 0 ~= err then
	print('open stream error!err='..err)
	
	-- ����3S
	l_sys.sleep(3000)
else
	print('open stream ok!res='..res)
	
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
