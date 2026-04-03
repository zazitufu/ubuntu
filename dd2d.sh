#!/bin/bash
### 本脚本用来快速DD为Debian12，默认为使用全球CDN的镜像 deb.debian.org
### 使用其他镜像可在此网址搜寻：https://www.debian.org/mirror/list
### 香港站为：http://ftp.hk.debian.org/debian/
### 20260403
### 本脚本用来快速DD为Debian12
### 针对中国大陆VPS增加了镜像源选择功能
### 默认root密码为Test233，首次登录后修改。

echo "------------------------------------------------"
echo "请选择安装时使用的 Debian 镜像源:"
echo "1) ftp.cn.debian.org(推荐)"
echo "2) 清华大学"
echo "3) 中科大"
echo "4) 全球 CDN (海外推荐)"
echo "------------------------------------------------"
read -p "请输入数字 [1-4] (默认为 1): " MIRROR_CHOICE

case $MIRROR_CHOICE in
    2)
        SELECTED_MIRROR="http://mirrors.tuna.tsinghua.edu.cn/debian/"
        ;;
    3)
        SELECTED_MIRROR="http://mirrors.ustc.edu.cn/debian/"
        ;;
    4)
        SELECTED_MIRROR="deb.debian.org/debian/"
        ;;
    *)
        SELECTED_MIRROR="ftp.cn.debian.org/debian/"
        ;;
esac

# 关键修正点：处理 dd.sh 对参数格式的敏感性
# 很多版本的 dd.sh 内部会自动补全 http://，如果你传入 https:// 会导致冲突
# 但华为云必须走加密连接。我们这里尝试提取 Host 和 Path。

FINAL_MIRROR=$(echo $SELECTED_MIRROR | sed -e 's|https://||' -e 's|http://||')

echo "正在尝试使用镜像: $SELECTED_MIRROR"

# 准备基础组件
apt-get update
apt-get install -y xz-utils openssl gawk file wget 
# 使用加速站中转下载
wget --no-check-certificate https://ghproxy.net/https://raw.githubusercontent.com/zazitufu/ubuntu/master/dd.sh
chmod a+x dd.sh
bash dd.sh -d 12 -v 64 -a --mirror "$FINAL_MIRROR" -p Test233
