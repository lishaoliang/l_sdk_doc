--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/3/7
--
-- @brief	使用curl短连接测试
-- @author	李绍良
--]]
local string = require("string")
local l_sys = require("l_sys")
local sh = l_sys.sh

local to_json =  require("demo.to_json")

local curl = {}

local cfg = {
	h_json = 'Content-Type: application/json',
	cookie = 'Cookie: llssid=852368;llauth=951235'
}

curl.get = function (ip, port, path, param)
	local dst = ''
	if 'string' == type(param) and '' ~= param then
		dst = string.format('\"%s:%d%s?%s\"', ip, port, path, param)
	else
		dst = string.format('\"%s:%d%s\"', ip, port, path)
	end	
	
	local header = string.format('-H \"%s\"', cfg.h_json)
	
	local cmd = string.format('curl -X GET %s %s', dst, header)
	--print('curl.GET cmd='..cmd)
	
	local ret, res = sh(cmd)
	--print('curl.GET ret='..ret, 'res='..res)
	return ret, res
end

curl.post = function (ip, port, path, msg)
	local dst = string.format('\"%s:%d%s\"', ip, port, path)
	local header = string.format('-H \"%s\"', cfg.h_json)
	
	local json = string.gsub(to_json(msg), '\"', '\\\"')
	local data = string.format('--data \"%s\"', json)
	
	local cmd = string.format('curl -X POST %s %s %s', dst, header, data)
	--print('curl.POST cmd='..cmd)
	
	local ret, res = sh(cmd)
	--print('curl.POST ret='..ret, 'res='..res)
	return ret, res
end

return curl
