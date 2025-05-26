#!/bin/bash
# 全面安装字体脚本 - 适配macOS

# 设置下载目录
DOWNLOAD_DIR=~/Downloads/font-installation
mkdir -p $DOWNLOAD_DIR
cd $DOWNLOAD_DIR

echo "==== 安装英文字体 ===="
# Source Serif Pro
echo "正在下载 Source Serif Pro..."
curl -L -o source-serif-pro.zip https://www.fontsquirrel.com/fonts/download/source-serif-pro
mkdir -p source-serif-pro
unzip -j source-serif-pro.zip -d source-serif-pro
cp source-serif-pro/*.otf ~/Library/Fonts/

# Source Sans Pro
echo "正在下载 Source Sans Pro..."
curl -L -o source-sans-pro.zip https://www.fontsquirrel.com/fonts/download/source-sans-pro
mkdir -p source-sans-pro
unzip -j source-sans-pro.zip -d source-sans-pro
cp source-sans-pro/*.otf ~/Library/Fonts/

# Source Code Pro
echo "正在下载 Source Code Pro..."
curl -L -o source-code-pro.zip https://www.fontsquirrel.com/fonts/download/source-code-pro
mkdir -p source-code-pro
unzip -j source-code-pro.zip -d source-code-pro
cp source-code-pro/*.otf ~/Library/Fonts/

# Inconsolata
echo "正在下载 Inconsolata..."
curl -L -o Inconsolata.zip https://www.fontsquirrel.com/fonts/download/Inconsolata
mkdir -p Inconsolata
unzip -j Inconsolata.zip -d Inconsolata
cp Inconsolata/*.otf ~/Library/Fonts/

echo "==== 安装中文字体 ===="
# Source Han Sans SC
echo "正在下载 Source Han Sans SC..."
curl -L -o SourceHanSansSC.zip https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansSC.zip
mkdir -p SourceHanSansSC
unzip SourceHanSansSC.zip -d SourceHanSansSC
cp SourceHanSansSC/OTF/SimplifiedChinese/*.otf ~/Library/Fonts/

# Source Han Serif SC
echo "正在下载 Source Han Serif SC..."
curl -L -o SourceHanSerifSC.zip https://github.com/adobe-fonts/source-han-serif/releases/download/2.001R/09_SourceHanSerifSC.zip
mkdir -p SourceHanSerifSC
unzip SourceHanSerifSC.zip -d SourceHanSerifSC
cp SourceHanSerifSC/OTF/SimplifiedChinese/*.otf ~/Library/Fonts/

echo "==== 安装韩文字体 ===="
# Source Han Sans K
echo "正在下载 Source Han Sans K..."
curl -L -o SourceHanSansK.zip https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansK.zip
mkdir -p SourceHanSansK
unzip SourceHanSansK.zip -d SourceHanSansK
cp SourceHanSansK/OTF/Korean/*.otf ~/Library/Fonts/

# Source Han Serif K
echo "正在下载 Source Han Serif K..."
curl -L -o SourceHanSerifK.zip https://github.com/adobe-fonts/source-han-serif/releases/download/2.001R/08_SourceHanSerifK.zip
mkdir -p SourceHanSerifK
unzip SourceHanSerifK.zip -d SourceHanSerifK
cp SourceHanSerifK/OTF/Korean/*.otf ~/Library/Fonts/

echo "==== 安装日文字体 ===="
# Source Han Sans J
echo "正在下载 Source Han Sans J..."
curl -L -o SourceHanSansJ.zip https://github.com/adobe-fonts/source-han-sans/releases/download/2.004R/SourceHanSansJ.zip
mkdir -p SourceHanSansJ
unzip SourceHanSansJ.zip -d SourceHanSansJ
cp SourceHanSansJ/OTF/Japanese/*.otf ~/Library/Fonts/

# Source Han Serif J
echo "正在下载 Source Han Serif J..."
curl -L -o SourceHanSerifJ.zip https://github.com/adobe-fonts/source-han-serif/releases/download/2.001R/07_SourceHanSerifJ.zip
mkdir -p SourceHanSerifJ
unzip SourceHanSerifJ.zip -d SourceHanSerifJ
cp SourceHanSerifJ/OTF/Japanese/*.otf ~/Library/Fonts/

echo "==== 清理临时文件 ===="
rm -rf $DOWNLOAD_DIR/*.zip

echo "==== 完成! ===="
echo "所有字体已安装到 ~/Library/Fonts/。"
echo "如果TeX仍无法识别字体，请尝试重启系统。"