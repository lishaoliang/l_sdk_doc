--[[
-- Copyright (c) 2019 �人˴������, All Rights Reserved
-- Created: 2019/11/13
--
-- @brief	��������NTP
-- @author	������
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/base.md
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

local ntp = {
	cmd = 'set_ntp',
	--llssid = '123456',
	--llauth = '123456',
	set_ntp = {
		enable = false,
		server = 'ntp1.aliyun.com',
		port = 123,
		interval = 604800
	}
}

local ret, res = l_sdk.request(id, to_json(ntp))
print('request set_ntp, ret='..ret, 'res='..res)


-- ����3S
l_sys.sleep(3000)


-- �ǳ�
l_sdk.logout(id)


-- sdk�˳�
l_sdk.quit()
