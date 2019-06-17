#!/bin/bash

# 清除python临时缓存目录
CLEAN_PWD=`pwd`

CLEAN_PYCACHE(){
	PATH_1=$1
	CLEAN_PATH=${CLEAN_PWD}/${PATH_1}
	echo "${CLEAN_PATH}"
	
	find ${CLEAN_PATH} -name "__pycache__" -type d | xargs rm -rf
}

CLEAN_PYCACHE site-packages
CLEAN_PYCACHE l_sdk
CLEAN_PYCACHE demo
