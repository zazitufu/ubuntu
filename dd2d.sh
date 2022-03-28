#!/bin/bash
### 本脚本用来快速DD为Debian11，默认为使用全球CDN的镜像 deb.debian.org
### 使用其他镜像可在此网址搜寻：https://www.debian.org/mirror/list
### 香港站为：http://ftp.hk.debian.org/debian/
### 默认root密码为Test233，首次登录后修改。
apt-get update
apt-get install -y xz-utils openssl gawk file wget 
wget https://raw.githubusercontent.com/zazitufu/ubuntu/master/dd.sh
chmod a+x dd.sh
bash dd.sh -d 11 -v 64 -a --mirror 'deb.debian.org/debian/' -p Test233
