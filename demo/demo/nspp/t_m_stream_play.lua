--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	极限流测试; 测试获取多路流, 解码显示一路流
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


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
	local err, res = l_sdk.request(id, json)

	return err, res
end

local m_stream = function (num, chnn, idx)
	local err = 0
	local id = 0
	for i = 1, num do
		-- 登录到设备
		err, id = login(target.ip, target.port, target.username, target.passwd)
		print('login ret='..err .. ' id='..id)
		
		local ret, res = open_stream(id, chnn, idx)
		print('open stream ret='..ret .. ' res='..res)
	end
	
	return err, id -- 返回最后一个登录的情况
end


-- sdk初始化
l_sdk.init('')


-- 打开多个流
-- 目前测试 Hi3519平台, 有线物理网口, 1G路由器环境下. 单个IPC可以拉取800Mbps的数据量
-- 若每路6M, 则可以拉取130-140路流
local count = 140

local chnn = 0
local idx = 0
local err, id = m_stream(count, chnn, idx);

	
--  内置播放器,需要win支持Opengl2.0以上
local dlg = l_sdk.open_wnd()	-- 打开窗口
dlg:bind(id, chnn, idx, 0)		-- 将窗口绑定到登录id, 通道, 流序号
while dlg:is_run() do			-- 窗口是否关闭
	l_sys.sleep(200)
end
dlg:close()


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
