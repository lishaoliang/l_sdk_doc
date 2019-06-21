--[[
-- 测试文档简要说明
-- 
-- 升级包介绍
--		*update					USB升级包
--		*update_v1.0.7.lpk		网络升级包
--		*update.txt				升级包简易描述: 
--			"hw_ver = h1.0.7"	文件系统版本
--			"sw_ver = v1.0.7"	软件版本
--			"build_time = *"	编译时间, 
--			"*update (md5) = *"	USB升级包文件的md5值
--			"*update_v1.0.7.lpk (md5) = *"	网络升级包的md5值
--		软件功能.xlsx			当前版本主要功能
-- 软件包是否损坏确认方法：Hash.exe工具, 对比文件md5值

一. 目录结构
	./
		Hash.exe		-- md5, sha1等文件校验工具
		md5sums.exe		-- win平台命令行md5计算
		llua.exe		-- 测试主执行程序
		python.exe		-- Python3.73主执行程序
		curl.exe		-- 第三方工具: http/https
		l_sdk.dll		-- sdk库
		*.dll			-- 其他辅助动态库
	
	
	./demo				-- 测试脚本目录
		readme.txt		-- 说明文件
		target.lua		-- 测试目标设备信息: IP地址,登录信息,wifi信息
		t_nspp.lua		-- 测试一部分nspp私有协议集合
		
		author.lua		-- lua脚本规范
		curl.lua		-- 封装调用"curl.exe"执行http/https短连接
		login.lua		-- 封装通用登录
		to_json.lua		-- 封装将lua的table转换为json文本
	
	
	./demo/nspp			-- 测试私有协议脚本目录
		t_base.lua		-- 测试获取设备基础信息: 例如设备名称
		t_discover.lua	-- 测试局域网络组播发现
		t_login.lua		-- 测试登录到设备
		
		t_m_stream_play.lua		-- 测试极限拉取多路码流, 播放一路码流
		t_set_dhcp.lua			-- 测试设置有线网口为dhcp自动获取IP
		t_set_image.lua			-- 测试设置图像参数
		t_set_img_awb.lua		-- 测试设置图像白平衡
		t_set_img_flip.lua		-- 测试设置图像垂直翻转
		t_set_img_mirror.lua	-- 测试设置图像水平镜像
		t_set_img_rotate.lua	-- 测试设置图像旋转
		t_set_ipv4.lua			-- 测试设置有线网口为静态IP地址
		t_set_stream.lua		-- 测试设置码流参数
		t_set_stream_pic.lua	-- 测试设置图片流参数
		t_stream.lua			-- 测试拉取一路码流,只拉取流不播放
		t_stream_pic.lua		-- 测试拉取图片流, 并保存成文件
		t_stream_play.lua		-- 测试拉取一路码流, 播放一路码流
		t_upgrade.lua			-- 测试升级指定的设备,指定的版本
		t_upgrade_auto.lua		-- 测试升级: 从局域网自动搜索设备, 自动搜索指定目录的升级包, 自动升级
		t_wireless_set_ap.lua	-- 测试设置设备的无线为 "AP"模式(即将设备作为热点)
		t_wireless_set_dhcp.lua	-- 测试设备在"STA"模式下时, 修改无线为dhcp自动获取IP地址
		t_wireless_set_ipv4.lua	-- 测试设备在"STA"模式下时, 修改无线为静态IP地址
		t_wireless_set_sta.lua	-- 测试设置设备的无线为 "STA"模式(即将设备作为终端连接到wifi路由器)
		

	./demo/l_sdk				-- Python库封装
	./demo/py					-- Python脚本目录
		target/__init__.py		-- py测试目标
		discover.py				-- 测试网络发现(直接使用接口)
		hello.py				-- 测试所有网络命令(直接使用接口)
		t_cv_nspp.py			-- 使用opencv测试NSPP协议视频流,图像已经对接numpy,可以使用cv对图像进行二次处理
		t_cv_rtsp.py			-- 使用opencv的RTSP协议连接视频流
		t_discover.py			-- 测试网络发现(使用封装接口)
		t_get.py				-- 测试所有获取网络命令(使用封装接口)
		t_version.py			-- 打印库版本
		test.py					-- 测试HTTP协议


二. 确认测试目标信息, 打开文件 ./demo/target.lua
	1. 目标IP地址: target.ip
	2. 目标端口: target.port
	3. 需要连接WIFI的路由器名称: target.wifi_ssid
	4. 需要连接WIFI的路由器密码: target.wifi_passwd


三. 将命令行切换到当前目录, 执行命令: dir
	将会看到如下打印:
	2018/12/24  09:34           830,536 curl.exe
	2019/03/18  17:02    <DIR>          demo
	2019/03/18  16:16           133,120 llua.exe
	2019/03/18  16:16           373,248 lua-5.3.5.dll
	2019/03/18  16:25            54,784 l_lua_res.dll
	2019/03/18  16:34         2,531,328 l_sdk.dll
	2019/03/12  13:50           144,896 l_tpool.dll
	

四. 发现局域网络设备, 执行命令: llua.exe ./demo/nspp/t_discover.lua 
	将会看到如下打印:
	multicast get devs:     {}
	multicast get devs:     [{"sn":"YDFE4EFDFESHEDFR","discover":{"mac":"00:13:09:FE:45:78","mac_wireless":"00:13:09:FE:45:79","name":"IPC","dev_type":"ipc","txt_enc":"","model":"wifi-ipc","port":80,"chnn_num":1,"sw_ver":"v1.0.7","hw_ver":"h1.0.7","md_enc":""},"ip":"192.168.1.247"}]
	

五. 测试登录到设备, 执行命令: llua.exe ./demo/nspp/t_login.lua
	将会看到如下打印:
	login ok!id=1000        admin@192.168.3.218:80


六. 测试播放设备码流, 执行命令: llua.exe ./demo/nspp/t_stream_play.lua
	将会看到如下打印: 并且会弹出一个窗口显示现场视频流
	login ok!id=1000        admin@192.168.3.218:80
	open stream ok!res={"cmd":"open_stream","open_stream":{"code":0}}


七. 测试设置无线
	1. 打开 ./demo/target.lua, 确认路由器wifi名称 和 密码
	
	2. 切换到STA模式, 执行命令: llua.exe ./demo/nspp/t_wireless_set_sta.lua
		login ok!id=1000        admin@192.168.3.218:80
		request set_wireless to sta, ret=0      res={"set_wireless":{"code":0},"cmd":"set_wireless"}
	
	3. 切换到AP模式, 执行命令: llua.exe ./demo/nspp/t_wireless_set_ap.lua
		login ok!id=1000        admin@192.168.3.218:80
		request set_wireless to ap, ret=0       res={"set_wireless":{"code":0},"cmd":"set_wireless"}
		

八. 测试抓取图片, 执行命令: llua.exe ./demo/nspp/t_stream_pic.lua
	将会看到如下打印: 如果成功, 在当前目录会看到一系列的 *.jpg 文件
	login ok!id=1000        admin@192.168.3.218:80
	open stream ok!res={"open_stream":{"code":0},"cmd":"open_stream"}
		

九. 其他测试命令:
	llua.exe ./demo/nspp/t_base.lua
	llua.exe ./demo/nspp/t_stream.lua
	

十. 批量测试命令: llua.exe ./demo/t_nspp.lua
	将执行各个测试脚本		

十一. 升级:
	先修改升级包实际存放的路径
	llua.exe ./demo/nspp/t_upgrade.lua
	
	将会看到如下打印: 
	request upgrade:        0       {"cmd":"upgrade","upgrade":{"code":0}}
	status_upgrade: doing   1.0
	status_upgrade: doing   11.0
	status_upgrade: doing   21.0
	status_upgrade: doing   31.0
	status_upgrade: doing   41.0
	status_upgrade: doing   51.0
	status_upgrade: doing   61.0
	status_upgrade: doing   71.0
	status_upgrade: doing   81.0
	status_upgrade: doing   90.0
	status_upgrade: done    100.0


十二. Python3使用命令: 打开文件 ./demo/py/target/__init__.py 修改目标设备信息
	例如: 
	./python.exe ./demo/py/discover.py
	./python.exe ./demo/py/hello.py
	./python.exe ./demo/py/t_cv_nspp.py
	./python.exe ./demo/py/t_cv_rtsp.py


十二. Python3扩展库:
	将如下文件放置到对应Python环境(注意32, 64位)中, 即可使用
	./demo/l_sdk/*.py			-- py接口封装
	./demo/l_sdk_py.pyd			-- py原始接口
	./demo/l_sdk.dll
	./demo/l_tpool.dll
	./demo/lua-5.3.5.dll
	ffmpeg系列动态库


--]]
