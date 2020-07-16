### 4、安装插件zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
### 5、安装插件zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
### 6、修改本用户~/.zshrc
sed -i 's/plugins=(git)/plugins=(\ngit\nzsh-autosuggestions\nzsh-syntax-highlighting\n)/' ~/.zshrc
### 7、添加路径/aabin
echo export PATH="$PATH:/aabin" >> ~/.zshrc
### 8、重启zsh
source ~/.zshrc
