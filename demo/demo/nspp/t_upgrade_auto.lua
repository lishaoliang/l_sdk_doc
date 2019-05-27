--[[
-- Copyright (c) 2019 武汉舜立软件, All Rights Reserved
-- Created: 2019/4/30
--
-- @brief	自动寻找设备, 自动寻找升级包, 进行升级
--  \n 网络发现局域网络设备, 发现不同版本(或强制升级), 则升级
-- @author	李绍良
-- @see https://github.com/lishaoliang/l_sdk_doc/blob/master/protocol/auth.md
--]]
local table = require("table")
local l_sys = require("l_sys")
local l_sdk = require("l_sdk")
local cjson = require("cjson")
local lfs = require("lfs")


local to_json =  require("demo.to_json")


local force_upgrade = true						-- 是否强制升级, 不管版本是否相同
local path_lpk = 'D:/work/ipc_my/l_dev/main'	-- 升级包路径	



-- 当前路径
local cur = lfs.currentdir()
local pwd = string.gsub(cur, '\\', '/') or cur	-- 统一使用目录符'/'


-- 找不到目录, 则使用当前目录
local path_lpk_attr = lfs.attributes(path_lpk)
if not path_lpk_attr or 'directory' ~= path_lpk_attr.mode then
	path_lpk_attr = pwd
end


-- @brief 获取某目录下所有文件
-- @param [in]	root_path[string]	待获取的根目录
-- @param [out]	files[table]		输出文件列表
-- @return 无
local get_all_files = nil
get_all_files = function (root_path, files)
	for entry in lfs.dir(root_path) do
		if '.' ~= entry and '..' ~= entry then
			local path = root_path .. '/' .. entry
			local attr = lfs.attributes(path)
			if 'table' == type(attr) then
				if 'directory' == attr.mode then
					get_all_files(path, files)
				elseif 'file' == attr.mode then
					table.insert(files, path)
				end
			else
				assert(false)
			end
		end
	end
end


local discover_devs = function ()
	-- 打开网络发现服务客户端
	l_sdk.discover_open('')

	-- 启用发现
	l_sdk.discover_run(true)
	
	local o = {}

	local count = 6
	while 0 < count do
		count = count - 1
		
		print('discover devs...')
	
		local devs = l_sdk.discover_get_devs()
		local dec, obj = pcall(cjson.decode, devs)

		if dec then
			for k, v in pairs(obj) do
				local ip = v['ip']
				if 'string' == type(ip) and '' ~= ip and nil == o[ip] then
					o[ip] = v	-- 符合规则的ip 加入进来
				end
			end
		end

		l_sys.sleep(500)
	end

	-- 关闭发现
	l_sdk.discover_run(false)

	-- 关闭网络发现服务客户端
	l_sdk.discover_close()
	
	return o
end


local find_lpk = function (root_path)
	
	local files = {}
	get_all_files(root_path, files)
	
	local lpks = {}
	for k, v in ipairs(files) do
		-- 初步按文件名称过滤
		-- 找到形如 '1.0.7.lpk'格式的文件
		local v1, v2, v3 = string.match(v, '.*([%d]+)%.([%d]+)%.([%d]+)%.lpk$')
		
		if v1 and v2 and v3 then
			local o ={
				v1 = v1,
				v2 = v2,
				v3 = v3,
				path = v,
			}
			
			table.insert(lpks, o)			
			-- TEST
			--table.insert(lpks, {v1='1',v2='0',v3='5',path = v,})
			--table.insert(lpks, {v1='2',v2='0',v3='18',path = v,})
			--table.insert(lpks, {v1='10',v2='1',v3='55',path = v,})
			--table.insert(lpks, {v1='10',v2='1',v3='55',path = 'aaa',})
			--table.insert(lpks, {v1='50',v2='0',v3='5',path = v,})
			--table.insert(lpks, {v1='0',v2='0',v3='5',path = v,})
		end
	end
	
	-- 从版本高到低 排序
	table.sort(lpks, function (lpk_a, lpk_b)
		local a1 = tonumber(lpk_a.v1)
		local a2 = tonumber(lpk_a.v2)
		local a3 = tonumber(lpk_a.v3)
		local b1 = tonumber(lpk_b.v1)
		local b2 = tonumber(lpk_b.v2)
		local b3 = tonumber(lpk_b.v3)
		
		local r
		if a1 == b1 then
			if a2 == b2 then
				r = a3 > b3
			else
				r = a2 > b2
			end
		else
			r = a1 > b1
		end	
		
		return r
	end)
	
	print('find lpks:--------------------------------')
	for k, v in ipairs(lpks) do
		print('*.lpk:' .. v['v1'] .. '.' .. v['v2'] .. '.' .. v['v3'], v['path'])
	end

	if 0 < #lpks then
		local v = lpks[1]
		return v.path, 'v' .. v['v1'] .. '.' .. v['v2'] .. '.' .. v['v3']
	end
	
	return '', ''
end


local upgrade_dev = function (ip, port, lpk)	
	local up = {
		cmd = 'upgrade',
		llssid = '123456',
		llauth = '123456',
		ip = ip,			-- 目标ip
		port = port,		-- 目标端口
		path = lpk,			-- 升级文件路径, 最好绝对路径
		upgrade = {
			username = 'admin',
			passwd = '123456'
		}
	}

	print('request upgrade:', ip .. ':' .. port)
	local ret, res = l_sdk.request(0, to_json(up))
	print('request upgrade:', ret, res)
	
	while 0 == ret do
		local up_status = {
			cmd = 'status_upgrade',	-- 查询升级状态
			ip = ip,				-- 目标ip
			port = port,			-- 目标端口
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
end


-- start ...
print('find *.lpk path:', path_lpk)
print('force upgrade:', force_upgrade)


-- sdk初始化
l_sdk.init('')


-- 找到升级文件
local lpk_file, lpk_ver = find_lpk(path_lpk)
if '' == lpk_file then
	print('no lpk file!path:', path_lpk)
else
	print('select lpk file:', lpk_file)
end


-- 搜索设备
local devs = discover_devs()
print('upgrade auto...')


-- 符合条件的自动升级
for k, v in pairs(devs) do
	local port = v['discover']['port']
	local ver = v['discover']['sw_ver']
	
	print('dev:', k .. ':' .. port, ver)
	
	if '' ~= lpk_file then
		if force_upgrade or
			ver ~= lpk_ver then
			upgrade_dev(k, port, lpk_file)
			
			-- 服务端升级检查间隔为1S, 这里等待几秒
			-- 如果测试服务端异常处理, 则可以注释掉休眠
			print('upgrade wait..')
			l_sys.sleep(3000)
		end
	end
end


-- sdk退出
l_sdk.quit()
