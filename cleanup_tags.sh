#!/bin/bash
# 全面清理错误位置的#@tab mxnet标记

# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}开始全面清理错误添加的#@tab mxnet标记...${NC}"

# 找出所有markdown文件
files=$(find . -name "*.md")
count=0

# 处理每个文件
for file in $files; do
  # 创建临时文件
  tmpfile=$(mktemp)
  
  # 处理各种错误模式
  awk '
  # 代码块前的#@tab mxnet
  /^#@tab mxnet$/ && (getline && $0 ~ /^```\{\.python \.input\}/) {
    print $0;  # 只打印```{.python .input}行，丢弃#@tab mxnet
    next;
  }
  
  # 标记连接到代码块开始
  /^#@tab mxnet```\{\.python \.input\}/ {
    gsub(/#@tab mxnet/, "");
    print;
    next;
  }
  
  # 连续的标记
  /^#@tab mxnet#@tab mxnet/ {
    gsub(/#@tab mxnet#@tab mxnet/, "#@tab mxnet");
    print;
    next;
  }
  
  # 其他情况保持不变
  {print}
  ' "$file" > "$tmpfile"
  
  # 检查文件是否被修改
  if ! cmp -s "$file" "$tmpfile"; then
    mv "$tmpfile" "$file"
    count=$((count+1))
    echo "已修复文件: $file"
  else
    rm "$tmpfile"
  fi
done

echo -e "${GREEN}清理完成！修复了 $count 个文件${NC}"