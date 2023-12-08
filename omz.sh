#!/bin/bash
##### version 0.8
##### 2023年12月8日 11点29分
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
alias syre="systemctl restart"
alias syst="systemctl status"
alias nano="nano -c"
alias lsn="lsof -i | grep LISTEN"
# 会影响scp 对路径中的通配符进行展开，先取消 echo alias scp=\'noglob scp\' >> ~/.zshrc

## Automatically quote globs in URL and remote references ，解决zsh下的通配符*的展开故障。
__remote_commands=(scp rsync)
autoload -U url-quote-magic
zle -N self-insert url-quote-magic
zstyle -e :urlglobber url-other-schema '[[ $__remote_commands[(i)$words[1]] -le ${#__remote_commands} ]] && reply=("*") || reply=(http https ftp)'

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

## 其他函数
# 重启并查看服务状态
function rere() {
   systemctl restart "$1"
   sleep 2
   systemctl status "$1"
}
EOF

### 8、解决agnoster主题，在使用自动补全时，第一个输入的字符会自动重复且无法删除的问题。
# 主题文件路径
THEME_FILE="$HOME/.oh-my-zsh/themes/agnoster.zsh-theme"

# 检查主题文件是否存在
if [ ! -f "$THEME_FILE" ]; then
    echo "agnoster.zsh-theme not found at $THEME_FILE"
    exit 1
fi

# 备份原始主题文件
cp "$THEME_FILE" "${THEME_FILE}.bak"

# 注释掉原有的 PROMPT 行，并添加新的 PROMPT 行
sed -i '/^PROMPT=/ s/^/#/' "$THEME_FILE"
echo "PROMPT='%{%f%b%k%}\$(build_prompt)%{ %}'" >> "$THEME_FILE"

# 提示完成
echo "agnoster theme modified successfully."
##

### 9、安装完毕以后，你需要将zsh替换为你的默认shell,输入下面命令进行替换:
## 切换默认shell为zsh
chsh -s /usr/bin/zsh
## 运行zsh shell
zsh
### 完结撒花
