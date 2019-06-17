#!/usr/bin/python3

#-*-coding:utf-8-*-
# 添加基础搜索目录
import l_sdk
l_sdk.append_path()

import target as tg
import sys
import time
import requests

#print(dir(requests))
#print(dir(time))

#http://192.168.1.247/luajson?cmd=hello,support,encrypt,login,system,ipv4,logout&llssid=123456&llauth=123456
#host = 'http://192.168.1.247:80/luajson'
host = 'http://' + tg.ip + ':' + str(tg.port) + tg.path


def req_test():
    try:
        res = requests.get(host, timeout=0.3)
        print(res.json())

        payload = {'cmd': 'support', 'llssid': '123456', 'llauth': '123456'}
        res = requests.post(host, timeout=0.3, json=payload)
        print(res.text)
    except Exception as e:
        print('requests expression...', e)
    finally:
        pass

    return 0

# N次请求
for i in range(1, 1000):
    req_test()
