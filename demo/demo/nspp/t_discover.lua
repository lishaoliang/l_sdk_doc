--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	测试网络发现设备
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/multicast/multicast.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


-- sdk初始化
l_sdk.init('')


-- 打开网络发现服务客户端
l_sdk.discover_open('')


-- 启用发现
l_sdk.discover_run(true)


local count = 11
while 0 < count do
	count = count - 1

	local devs = l_sdk.discover_get_devs()
	print('discover get devs:', devs)

	l_sys.sleep(1000)
end


-- 关闭发现
l_sdk.discover_run(false)


-- 关闭网络发现服务客户端
l_sdk.discover_close()

-- sdk退出
l_sdk.quit()
