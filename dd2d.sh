#!/bin/bash
### 20260403
### 本脚本用来快速DD为Debian12
### 针对中国大陆VPS增加了镜像源选择功能
### 默认root密码为Test233，首次登录后修改。
# ... (前面的安装基础组件和下载 dd.sh 部分保持不变) ...

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
        SELECTED_MIRROR="http://ftp.cn.debian.org/debian/"
        ;;
esac

# 关键修正点：处理 dd.sh 对参数格式的敏感性
# 很多版本的 dd.sh 内部会自动补全 http://，如果你传入 https:// 会导致冲突
# 但华为云必须走加密连接。我们这里尝试提取 Host 和 Path。

FINAL_MIRROR=$(echo $SELECTED_MIRROR | sed -e 's|https://||' -e 's|http://||')

echo "正在尝试使用镜像: $SELECTED_MIRROR"

# 如果 dd.sh 依然报错，请尝试将下面命令中的 --mirror 后面直接写死为：
# mirrors.huaweicloud.com/debian/
bash dd.sh -d 12 -v 64 -a --mirror "$FINAL_MIRROR" -p Test233
