#!/bin/bash
##### version 0.6
##### 2022年3月30日 23点05分
##### 运行完后reboot一下系统。使用方法:
##### bash <(curl -s -L https://github.com/zazitufu/ubuntu/raw/master/omz.sh)
##### bash <(curl -sL https://git.io/zaziomz)
### 0、先安装curl
apt-get -y install curl

### 1、安装zsh 
apt-get update
apt-get -y install zsh git wget
### 2、安装Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
### 3、安装插件zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
### 4、安装插件zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
### 5、修改本用户~/.zshrc，包括主题改为agnoster，添加插件
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' ~/.zshrc
sed -i 's/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\nzsh-syntax-highlighting\n)/' ~/.zshrc

### 6 建立两个目录
mkdir /aalog && mkdir /aabin

### 7、添加下面整段环境变量到 ~/.zshrc
cat << "EOF" >> ~/.zshrc
export PATH=$PATH:/aabin
alias cdl="cd /aalog"
alias cdb="cd /aabin"
alias gip="curl ip.test.vin"
alias sysre="systemctl restart"
alias sysst="systemctl status"
alias rere='function _rere(){ systemctl restart "$1" && systemctl status "$1"; };_rere'
alias nano="nano -c"
# 会影响scp 对路径中的通配符进行展开，先取消 echo alias scp=\'noglob scp\' >> ~/.zshrc

## Automatically quote globs in URL and remote references ，解决zsh下的通配符*的展开故障。
#__remote_commands=(scp rsync)
#autoload -U url-quote-magic
#zle -N self-insert url-quote-magic
#zstyle -e :urlglobber url-other-schema '[[ $__remote_commands[(i)$words[1]] -le ${#__remote_commands} ]] && reply=("*") || reply=(http https ftp)'

## 代理服务器
# set a local proxy
function proxyl() {
    export ALL_PROXY="socks5h://127.0.0.1:port"
}
# set a remote proxy
function proxyr() {
    export ALL_PROXY="socks5h://tufu:password@ip:port"
}
# unset proxy
function noproxy() {
    unset ALL_PROXY
}
EOF

### 8、安装完毕以后，你需要将zsh替换为你的默认shell,输入下面命令进行替换:
zsh
chsh -s /usr/bin/zsh
### 完结撒花
