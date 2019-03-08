# 编译命令行 : make
# 清除命令行 : make clean
# 环境: Ubuntu 16.04.6 LTS (GNU/Linux 4.4.0-142-generic x86_64)
# 安装: sudo apt install pandoc
# pandoc项目: https://github.com/jgm/pandoc
# 
SHELL = /bin/bash

# 从目录检索*.md文件
DIRS = ../protocol

#编译目标名称
TARGET = ./l_sdk.docx

#编译器
CXX		 = pandoc
MAKE	 = make
RM		 = -rm -f

#md文件
FIND_FILES_MD = $(wildcard $(dir)/*.md)
SOURCES = $(foreach dir, $(DIRS), $(FIND_FILES_MD))

LIB_OBJS = $(addsuffix .docx, $(SOURCES))

# 从目录查找的无法确定次序, 这里手工编辑文档次序
-include page_idx
MD_FILES = $(PAGE_ALL)


.PHONY:all clean

all: docx

docx : $(TARGET)

%.md.docx: %.md
	$(CXX) -s -o $@ $<
	
$(TARGET):
	$(tip_all)
	$(CXX) -s -o $(TARGET) $(MD_FILES)
	
clean:
	@echo "++++++++++++++++ make clean ++++++++++++++"
	@echo "++ DIRS = $(DIRS)"
	@echo "++ RM = $(RM)"
	$(RM) $(LIB_OBJS)
	$(RM) $(TARGET)
	@echo "++++++++++++++++++++++++++++++++++++++++++"

define tip_all
	@echo "+++++++++++++ make $(TARGET) ++++++++++++++"
	@echo "++ CXX = $(CXX)"
	@echo "++ SOURCES = $(notdir $(SOURCES))"
	@echo "++ TARGET = $(TARGET)"
	@echo "++++++++++++++++++++++++++++++++++++++++++"
endef
