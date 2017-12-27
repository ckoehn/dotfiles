echo '# Install diff-so-fancy'
curl -o ~/bin/diff-so-fancy 'https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy'
chmod +x ~/bin/diff-so-fancy

echo '# Install zgen'
ln -sf $PWD/zsh/.zshrc ~/.zshrc
[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git ~/.zgen --depth 1
[ ! -d ~/.zsettings ] && ln -s $PWD/zsh/settings ~/.zsettings

echo '# Change shell to zsh'
[ -f /usr/bin/zsh ] && chsh -s /usr/bin/zsh

echo '# Install fzf'
[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf --depth 1
~/.fzf/install --no-update-rc --completion --key-bindings

echo '# Link git configuration'
ln -sf $PWD/.gitconfig ~/.gitconfig
ln -sf $PWD/.gitignore ~/.gitignore
[ ! -f ~/.gitconfig.local ] && touch ~/.gitconfig.local

echo '# Link tmux configuration'
ln -sf $PWD/.tmux.conf ~/.tmux.conf
[ ! -f ~/.tmux.conf.local ] && touch ~/.tmux.conf.local

echo '# Link terminator configuration'
mkdir -p ~/.config/terminator
ln -sf $PWD/terminator.config ~/.config/terminator/config
