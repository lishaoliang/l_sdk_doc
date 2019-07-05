///////////////////////////////////////////////////////////////////////////
//  Copyright(c) 2019, 武汉舜立软件 All Rights Reserved
//  Created: 2019/06/19
//
/// @file    l_sdk_history.h
/// @brief   SDK版本修改记录
///  \n '+' 添加, '-' 删除, 'm' 修改, '*' 备注
/// @version 0.1
/// @author  李绍良
/// @history 修改历史
///  \n 2019/06/19 0.1 创建文件
/// @see https://github.com/lishaoliang/l_sdk_doc
/// @warning 没有警告
///////////////////////////////////////////////////////////////////////////


/*


-- TIME: 2019/7/1   ~   2019/7/5
+ 支持iOS版本
+ demo创建显示窗口支持传入: 解码器ID, 初始窗口宽, 初始窗口高, 窗口标题
m 修正l_sdk_logout之后,没有关闭socket的Bug
m 修正l_sdk_login到不存在的IP时,没有关闭socket的Bug
- 去除显示部分接口: 因各个平台显示差异大, 兼容性问题


-- TIME: 2019/6/19
+ 解码器模块支持传入json参数字段"pix_fmt",设定解码之后目标像素格式

-- Python
+ 添加Python版本接口封装(仅支持Win64)
+ 添加解码图像接口,输出numpy格式数据,可直接作为opencv等数据源使用


-- TIME: 2019/5/31  v1.0.11
+ 添加连接状态查询接口"status_connect"
m 调整demo的opengl视频按视频宽高比例显示

*/

