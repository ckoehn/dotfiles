#!/bin/bash

DIR=$PWD

echo '# Install fonts'
[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts
ln -sf $DIR/fonts/* ~/.local/share/fonts/
fc-cache -f

if [ ! hash diff-so-fancy 2>/dev/null ]; then
	echo '# Install diff-so-fancy'
	curl -o ~/bin/diff-so-fancy 'https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy'
	chmod +x ~/bin/diff-so-fancy
else
	echo '# Skip diff-so-fancy -> already installed'
fi

echo '# Install zgen'
ln -sf $DIR/zsh/.zshrc ~/.zshrc
[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git ~/.zgen --depth 1
[ ! -d ~/.zsettings ] && ln -s $DIR/zsh/settings ~/.zsettings

echo '# Change shell to zsh'
[ -f /usr/bin/zsh ] && chsh -s /usr/bin/zsh

echo '# Install fzf'
[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf --depth 1
~/.fzf/install --no-update-rc --completion --key-bindings

echo '# Link git configuration'
ln -sf $DIR/.gitconfig ~/.gitconfig
ln -sf $DIR/.gitignore ~/.gitignore
[ ! -f ~/.gitconfig.local ] && touch ~/.gitconfig.local

echo '# Link vim configuration'
[ ! -d ~/.vim ] && ln -s $DIR/vim ~/.vim
ln -sf $DIR/vim/vimrc ~/.vimrc
vim +PlugInstall +qall

echo '# Link tmux configuration'
ln -sf $DIR/.tmux.conf ~/.tmux.conf
[ ! -f ~/.tmux.conf.local ] && touch ~/.tmux.conf.local

echo '# Link terminator configuration'
[ ! -d ~/.config/terminator ] && mkdir -p ~/.config/terminator
ln -sf $DIR/terminator.config ~/.config/terminator/config

echo '# Link Xmodmap configuration'
ln -sf $DIR/.Xmodmap ~/.Xmodmap
