--[[
-- Copyright (c) 2019 �人˴�����, All Rights Reserved
-- Created: 2019/11/13
--
-- @brief	��������OSDʱ���
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/osd.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


-- sdk��ʼ��
l_sdk.init('')


-- ��¼���豸
local err, id = login(target.ip, target.port, target.username, target.passwd)


-- ��ӡ��¼���
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end

local osd_timestamp = {
	cmd = 'set_osd_timestamp',
	--llssid = '123456',
	--llauth = '123456',
	set_osd_timestamp = {
		chnn = 0,
		enable = false,
		format = 'YY-MM-DD HH:MM:SS.3',
		pos = 'right,top',
		font_size = 'middle'
	}
}

local ret, res = l_sdk.request(id, to_json(osd_timestamp))
print('request set_osd_timestamp, ret='..ret, 'res='..res)


-- ����3S
l_sys.sleep(3000)


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
