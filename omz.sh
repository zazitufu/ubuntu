#!/bin/bash
### 1、安装zsh 
apt-get update
apt-get -y install zsh git wget
### 2、安装Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
### 3、安装插件zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
### 4、安装插件zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
### 5、修改本用户~/.zshrc
sed -i 's/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\nzsh-syntax-highlighting\n)/' ~/.zshrc
### 6 建立两个目录
mkdir /aalog && mkdir /aabin
### 7、添加路径/aabin
echo \'export PATH=\$PATH:/aabin\' >> ~/.zshrc
### 8、安装完毕以后，你需要将zsh替换为你的默认shell,输入下面命令进行替换:
chsh -s /bin/zsh
### 9、重启zsh
source ~/.zshrc
