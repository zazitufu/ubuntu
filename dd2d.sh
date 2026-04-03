#!/bin/bash
### 20260403
### 本脚本用来快速DD为Debian12
### 针对中国大陆VPS增加了镜像源选择功能
### 默认root密码为Test233，首次登录后修改。

# 准备基础组件
apt-get update
apt-get install -y xz-utils openssl gawk file wget 

# 下载主脚本
wget --no-check-certificate https://ghproxy.net/https://raw.githubusercontent.com/zazitufu/ubuntu/master/dd.sh
chmod a+x dd.sh

# 镜像源选择菜单
echo "------------------------------------------------"
echo "请选择安装时使用的 Debian 镜像源:"
echo "1) 腾讯云 (北京/上海等国内机器推荐)"
echo "2) 清华大学 (国内通用教育网/多线推荐)"
echo "3) 华为云 (国内电信/联通推荐)"
echo "4) 全球 CDN (deb.debian.org - 海外机器推荐)"
echo "------------------------------------------------"
read -p "请输入数字 [1-4] (默认为 1): " MIRROR_CHOICE

case $MIRROR_CHOICE in
    2)
        SELECTED_MIRROR="https://mirrors.tuna.tsinghua.edu.cn/debian/"
        ;;
    3)
        SELECTED_MIRROR="https://mirrors.huaweicloud.com/debian/"
        ;;
    4)
        SELECTED_MIRROR="http://deb.debian.org/debian/"
        ;;
    *)
        # 默认为腾讯云，因为其在各大云服务商内网互联通常较快
        SELECTED_MIRROR="http://mirrors.tencentyun.com/debian/"
        ;;
esac

echo "已选择镜像源: $SELECTED_MIRROR"
echo "正在开始重装系统，请勿断开连接..."

# 执行 DD 脚本
# 注意：dd.sh 的 --mirror 参数通常不需要带 http:// 前缀，只需 host/path
# 但为了兼容性，此处剥离协议头（如果 dd.sh 内部有特定要求）
FINAL_MIRROR=$(echo $SELECTED_MIRROR | sed -e 's|https://||' -e 's|http://||')

bash dd.sh -d 12 -v 64 -a --mirror "$FINAL_MIRROR" -p Test233
