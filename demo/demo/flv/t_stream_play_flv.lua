--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/12/25
--
-- @brief	测试获取 http_flv 码流
-- @author	李绍良
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


-- sdk初始化
l_sdk.init('')

--print(conn_status('1000', '1001', '1002'))

local chnn = 0
local idx = 0	-- 0.主码流, 1.子码流

-- '/luaflv/chnn0/idx0'
-- '/luaflv/chnn0/idx1'
local path = string.format('/luaflv/chnn%d/idx%d', chnn, idx)


-- 登录到设备
local err, id = login(target.ip, target.port, target.username, target.passwd, 'http_flv', 'GET', path)


-- 打印登录结果
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end


if 0 == err then
	--  内置播放器,需要win支持Opengl2.0以上
	local dlg = l_sdk.open_wnd()	-- 打开窗口
	dlg:bind(id, 0, 0, 0)			-- 将窗口绑定到登录id, 通道, 流序号
	
	local cs_tc = 0
	while dlg:is_run() do			-- 窗口是否关闭
		cs_tc = cs_tc + 200
		if 3000 <= cs_tc then
			cs_tc = 0
			print(conn_status(tostring(id)))
		end
		
		l_sys.sleep(200)
	end
	
	dlg:close()
end

-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
