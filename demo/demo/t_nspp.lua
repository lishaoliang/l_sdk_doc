--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	批量测试目标nspp协议
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc
--]]
local l_sys = require("l_sys")


local files = {
	"demo.nspp.t_discover",
	"demo.nspp.t_login",
	"demo.nspp.t_base",
	"demo.nspp.t_stream",
	"demo.nspp.t_stream_pic",
	"demo.nspp.t_stream_play"
}


print('TEST nspp start *************************************')



for k, v in pairs(files) do	
	if 'string' == type(v) then
		
		print('TEST start...', v)
		require(v)
		print('TEST over...', v)
		
		l_sys.sleep(3000)
	end
end



print('TEST nspp over *************************************')

-- 结束
