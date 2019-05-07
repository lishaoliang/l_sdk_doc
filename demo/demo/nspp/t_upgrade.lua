--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/4/24
--
-- @brief	测试升级设备
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")


local target = require("demo.target")
local to_json =  require("demo.to_json")



local path_lpk = 'Z:/work/ipc_my/l_dev/main/f701w_update_v1.0.7.lpk'


-- sdk初始化
l_sdk.init('')


local up = {
	cmd = 'upgrade',
	llssid = '123456',
	llauth = '123456',
	ip = target.ip,			-- 目标ip
	port = target.port,		-- 目标端口
	path = path_lpk,		-- 升级文件路径, 最好绝对路径
	upgrade = {
		username = 'admin',
		passwd = '123456'
	}
}


local ret, res = l_sdk.request(0, to_json(up))
print('request upgrade:', ret, res)


while true do
	local up_status = {
		cmd = 'status_upgrade',		-- 升级状态
		ip = target.ip,				-- 目标ip
		port = target.port,			-- 目标端口
	}

	local ret, res = l_sdk.request(0, to_json(up_status))
	--print('request status_upgrade:', ret, res)
	
	if 0 == ret then
		local dec, o = pcall(cjson.decode, res)
		local o_s_upgrade = o['status_upgrade']
		local percentage = o_s_upgrade['percentage']
		local state = o_s_upgrade['status']

		print('status_upgrade:', state, percentage)
	
		if 'doing' == state then	-- 还在执行
			
		elseif 'done' == state then	-- 完毕
			break
		end
	else
		print('request status_upgrade error:', ret)
		break
	end

	l_sys.sleep(100)
end



-- sdk退出
l_sdk.quit()
