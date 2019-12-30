--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/11/21
--
-- @brief	(RTSP协议)极限流测试; 测试获取多路流, 解码显示一路流
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/stream.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


local target = require("demo.target")
local to_json =  require("demo.to_json")
local login = require("demo.login")


local m_stream = function (num, path)
	local err = 0
	local id = 0
	for i = 1, num do
		-- 登录到设备
		err, id = login(target.ip, target.port, target.username, target.passwd, 'rtsp', nil, path)
		print('login rtsp ret='..err .. ' id='..id)
	end
	
	return err, id -- 返回最后一个登录的情况
end


-- sdk初始化
l_sdk.init('')


-- 打开多个流
-- 目前测试 Hi3519平台, 有线物理网口, 1G路由器环境下. 单个IPC可以拉取800Mbps的数据量
-- 若每路6M, 则可以拉取130-140路流
local count = 30


--  rtsp主码流: rtsp://admin:123456@192.168.1.247:80/chnn0/idx0
--  rtsp子码流: rtsp://admin:123456@192.168.1.247:80/chnn0/idx1
--  rtsp默认子码流: rtsp://admin:123456@192.168.1.247:80

local chnn = 0
local idx = 0	-- 0.主码流, 1.子码流

-- '/chnn0/idx0'
-- '/chnn0/idx1'
local path = string.format('/chnn%d/idx%d', chnn, idx)


local err, id = m_stream(count, path);

	
--  内置播放器,需要win支持Opengl2.0以上
local dlg = l_sdk.open_wnd()	-- 打开窗口
dlg:bind(id, 0, 0, 0)		-- 将窗口绑定到登录id, 通道, 流序号
while dlg:is_run() do			-- 窗口是否关闭
	l_sys.sleep(200)
end
dlg:close()


-- 登出
l_sdk.logout(id)


-- sdk退出
l_sdk.quit()
