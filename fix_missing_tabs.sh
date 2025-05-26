#!/bin/bash
# 检测缺少#@tab mxnet标记的代码块并正确修复 (完全兼容macOS)

# 设置颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}开始检测缺少#@tab mxnet标记的文件...${NC}"

# 找出所有markdown文件
files=$(find . -name "*.md")

# 计数器
found=0

# 创建临时目录存储问题信息
tmpdir=$(mktemp -d)
problems_file="$tmpdir/problems.txt"
touch "$problems_file"

# 检查每个文件
for file in $files; do
  # 使用grep直接找到代码块开始
  line_nums=$(grep -n '```{.python .input}' "$file" | cut -d: -f1)
  
  for line_num in $line_nums; do
    # 获取下一行
    next_line=$(sed -n "$((line_num+1))p" "$file")
    
    # 检查下一行是否已有#@tab标记
    if [[ ! "$next_line" =~ ^#@tab ]]; then
      found=$((found+1))
      echo -e "${YELLOW}问题 $found${NC}: ${file}:${line_num}"
      echo -e "  代码块开始后缺少#@tab标记:"
      echo -e "  $(sed -n "${line_num}p" "$file")"
      echo -e "  $next_line"
      echo ""
      
      # 保存问题信息
      echo "$file:$line_num" >> "$problems_file"
    fi
  done
done

# 如果没有找到问题
if [ $found -eq 0 ]; then
  echo -e "${GREEN}没有找到缺少#@tab mxnet标记的代码块！${NC}"
  rm -rf "$tmpdir"
  exit 0
fi

# 询问是否修复问题
echo -e "${YELLOW}找到 $found 个缺少#@tab mxnet标记的代码块。${NC}"
read -p "是否要为这些代码块添加#@tab mxnet标记? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  # 获取唯一的文件列表
  unique_files=$(cut -d: -f1 "$problems_file" | sort -u)
  
  # 处理每个文件
  for file in $unique_files; do
    echo -e "处理文件: ${file}"
    
    # 获取该文件的所有行号并从大到小排序
    file_lines=$(grep "^$file:" "$problems_file" | cut -d: -f2 | sort -nr)
    
    # 输出调试信息
    echo -e "  按从大到小顺序处理行: $file_lines"
    
    # 创建临时文件
    tmpfile=$(mktemp)
    cp "$file" "$tmpfile"
    
    # 从大到小处理每一行
    for line_num in $file_lines; do
      echo -e "  修复行 $line_num..."
      
      # 创建新的临时文件
      new_tmpfile=$(mktemp)
      
      # 使用awk在指定行号后插入内容
      awk -v ln="$line_num" '
      NR == ln {
        print $0;          # 打印当前行
        print "#@tab mxnet"; # 插入新行
        next;              # 跳到下一行
      }
      { print }            # 打印所有其他行
      ' "$tmpfile" > "$new_tmpfile"
      
      # 替换临时文件
      mv "$new_tmpfile" "$tmpfile"
    done
    
    # 最后用修改后的文件替换原文件
    mv "$tmpfile" "$file"
  done
  
  echo -e "${GREEN}所有问题已修复！${NC}"
  echo -e "现在可以尝试运行: d2lbook build eval --tab mlx"
else
  echo -e "${YELLOW}未进行修复，请手动添加标记。${NC}"
fi

# 清理临时目录
rm -rf "$tmpdir"