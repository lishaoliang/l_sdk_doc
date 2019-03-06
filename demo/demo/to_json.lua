--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/6
--
-- @brief	将lua的table转换为json文本
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc
--]]

local cjson = require("cjson")


-- @brief 将lua的table转换为json文本
-- @param [in]  	o[table]	lua的table
-- @return [string]	json字符串
local to_json = function (o)
	local t = type(o)
	
	if 'string' == t then
		return o
	elseif 'table' == t then
		local txt = cjson.encode(o)
		return txt
	else
		assert(false)
	end
	
	return '{}'
end

return to_json
