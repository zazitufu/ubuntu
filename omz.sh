#!/bin/bash
### 1、安装zsh 
apt-get -y install zsh git wget
### 2、安装完毕以后，你需要将zsh替换为你的默认shell,输入下面命令进行替换:
chsh -s /bin/zsh
### 3、安装Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
### 4、安装插件zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
### 5、安装插件zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
### 6、修改本用户~/.zshrc
sed -i 's/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\nzsh-syntax-highlighting\n)/' ~/.zshrc
### 7、添加路径/aabin
echo \'export PATH=\"\$PATH:/aabin\"\' >> ~/.zshrc
### 8、重启zsh
source ~/.zshrc
