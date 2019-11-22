--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/11/20
--
-- @brief	测试使用RTSP协议播放码流
-- @author	李绍良
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
		--llssid = '123456',	-- l_sdk自动将此域补充完成
		--llauth = '123456',	-- l_sdk自动将此域补充完成
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


-- sdk初始化
l_sdk.init('')

--print(conn_status('1000', '1001', '1002'))


-- 主码流 eg. rtsp://192.168.1.247:80/chnn=0&id=1
-- 子码流 eg. rtsp://192.168.1.247:80/chnn=0&id=0

local chnn = 0
local idx = 0	-- 0.主码流, 1.子码流

local rtsp_id = function (idx)
	if 0 ~= idx then
		return 0 -- 子码流 rtsp0
	end
	
	return 1 -- 主码流 rtsp1
end

-- '/chnn=0&id=1'
-- '/chnn=0&id=0'
local path = string.format('/chnn=%d&id=%d', chnn, rtsp_id(idx))


-- 登录到设备
local err, id = login_rtsp(target.ip, target.port, path, target.username, target.passwd)


-- 打印登录结果
if 0 ~= err then
	print('login error!'.. 'err=' .. err,  target.username .. '@' .. target.ip .. ':'..target.port .. ' -p ' .. target.passwd)
else	
	print('login ok!'.. 'id=' .. id, target.username .. '@' .. target.ip .. ':'..target.port)
end

local err, res = open_stream(id, chnn, idx);
if 0 ~= err then
	print('open stream error!err='..err)
	
	-- 休眠3S
	l_sys.sleep(3000)
else
	print('open stream ok!res='..res)
	
	--  内置播放器,需要win支持Opengl2.0以上
	local dlg = l_sdk.open_wnd()	-- 打开窗口
	dlg:bind(id, chnn, idx, 0)		-- 将窗口绑定到登录id, 通道, 流序号
	
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
