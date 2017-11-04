ln -sf $PWD/zsh/.zshrc ~/.zshrc
[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git ~/.zgen --depth 1
[ ! -d ~/.zsettings ] && ln -s $PWD/zsh/settings ~/.zsettings
[ -f /usr/bin/zsh ] && chsh -s /usr/bin/zsh

[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf --depth 1
~/.fzf/install --no-update-rc --completion --key-bindings

ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.gitignore ~/.gitignore
[ ! -f ~/.gitconfig.local ] && touch ~/.gitconfig.local

ln -sf $PWD/.tmux.conf ~/.tmux.conf
[ ! -f ~/.tmux.conf.local ] && touch ~/.tmux.conf.local
