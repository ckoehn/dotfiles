#!/bin/bash

DIR=$PWD

echo '# Check requirements'
if ! command -v ag >/dev/null; then
	echo "-> Please install 'The Silver Searcher'"
	exit 1
fi
if ! command -v diff-so-fancy >/dev/null; then
	echo "-> Please install 'diff-so-fancy'"
	exit 1
fi
if ! command -v xsel >/dev/null; then
	echo "-> Please install 'xsel'"
	exit 1
fi

echo '# Install fonts'
[ ! -d ~/.local/share/fonts ] && mkdir -p ~/.local/share/fonts
ln -sf $DIR/fonts/* ~/.local/share/fonts/
fc-cache -f

echo '# Install zgen'
ln -sf $DIR/zsh/zshenv ~/.zshenv
ln -sf $DIR/zsh/zshrc ~/.zshrc
[ ! -d ~/.zsettings ] && ln -s $DIR/zsh/settings ~/.zsettings
[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git ~/.zgen --depth 1

echo '# Change shell to zsh'
[ -f /usr/bin/zsh ] && chsh -s /usr/bin/zsh

echo '# Install fzf'
[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf --depth 1
~/.fzf/install --no-update-rc --completion --key-bindings

echo '# Link git configuration'
ln -sf $DIR/git/gitconfig ~/.gitconfig
ln -sf $DIR/git/gitignore ~/.gitignore
[ ! -f ~/.gitconfig.local ] && touch ~/.gitconfig.local

echo '# Link vim configuration'
[ ! -d ~/.vim ] && ln -s $DIR/vim ~/.vim
ln -sf $DIR/vim/vimrc ~/.vimrc
vim +PlugInstall +qall

echo '# Link terminator configuration'
[ ! -d ~/.config/terminator ] && mkdir -p ~/.config/terminator
ln -sf $DIR/terminator.config ~/.config/terminator/config

echo '# Link rofi configuration'
[ ! -d ~/.config/rofi ] && mkdir -p ~/.config/rofi
ln -sf $DIR/rofi/*.rasi ~/.config/rofi/

echo '# Link Xmodmap configuration'
ln -sf $DIR/.Xmodmap ~/.Xmodmap
