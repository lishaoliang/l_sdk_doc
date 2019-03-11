

local curl = require("demo.curl")
local target = require("demo.target")


local req = {
	cmd = 'hello',
	llssid = '123456',
	llauth = '123456'
}


--local ret, res = curl.post(target.ip, target.port, target.path, req)
--print('post ret='..ret, 'res='..res)


local ret, res = curl.get(target.ip, target.port, target.path, 'cmd=hello,support,encrypt')
print('get ret='..ret, 'res='..res)


--local ret, res = curl.get('www.baidu.com', 80, '/')
--print('get ret='..ret, 'res='..res)
