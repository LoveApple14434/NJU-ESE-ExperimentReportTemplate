# Makefile for pandoc document conversion

# 目录设置
SRC_DIR := .
BUILD_DIR := build

# 源文件
SOURCE := $(SRC_DIR)/content.md
TEMPLATE := $(SRC_DIR)/template2.tex

# 目标文件
PDF_TARGET := $(BUILD_DIR)/test.pdf
TEX_TARGET := $(BUILD_DIR)/test.tex

# pandoc 命令及通用参数
PANDOC := pandoc
PANDOC_COMMON := --template=$(TEMPLATE) --filter=pandoc-crossref --syntax-highlighting=idiomatic
PANDOC_LUA := --lua-filter scripts/auto-rotate-table-headers.lua
PANDOC_PDF_FLAGS := --pdf-engine=xelatex

# 默认目标：同时生成 PDF 和 TeX
all: $(TEX_TARGET) $(PDF_TARGET)

# 生成 PDF
$(PDF_TARGET): $(SOURCE) $(TEMPLATE) | $(BUILD_DIR)
	$(PANDOC) $(SOURCE) -o $@ $(PANDOC_COMMON) $(PANDOC_PDF_FLAGS) $(PANDOC_LUA)

# 生成 TeX（不需要 --pdf-engine）
$(TEX_TARGET): $(SOURCE) $(TEMPLATE) | $(BUILD_DIR)
	$(PANDOC) $(SOURCE) -o $@ $(PANDOC_COMMON) $(PANDOC_LUA)

# 创建 build 目录（如果不存在）
$(BUILD_DIR):
	mkdir -p $@

# 清理生成的文件
clean:
	rm -f $(PDF_TARGET) $(TEX_TARGET)
	-rmdir $(BUILD_DIR) 2>/dev/null

.PHONY: all clean