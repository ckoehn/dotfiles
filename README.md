dotfiles
========

## Installation

1. Clone this repository into ".dotfiles": `git clone git://github.com/ckoehn/dotfiles.git ~/.dotfiles`
2. Link configuration files: `ln -s .dotfiles/git.conf ~/.gitconfig && ln -s .dotfiles/tmux.conf ~/.tmux.conf && ln -s .dotfiles/bash.conf ~/.bash.conf`
3. Include bash settings: `echo 'if [ -f ~/.bash.conf ]; then . ~/.bash.conf; fi' >> ~/.bashrc` 
4. Create local configuration files: `touch ~/.git.conf.local && touch ~/.tmux.conf.local`
