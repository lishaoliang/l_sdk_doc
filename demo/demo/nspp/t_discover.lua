--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	测试组播搜索设备
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/multicast/multicast.md
--]]
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")


-- sdk初始化
l_sdk.init('')


-- 打开组播设备
l_sdk.multicast_open()


-- 启用组播搜索
l_sdk.multicast_discover(true)


local count = 11
while 0 < count do
	count = count - 1

	local devs = l_sdk.multicast_get_devs()
	print('multicast get devs:', devs)

	l_sys.sleep(1000)
end


-- 关闭组播搜索
l_sdk.multicast_discover(false)


-- 关闭组播设备
l_sdk.multicast_close()

-- sdk退出
l_sdk.quit()
