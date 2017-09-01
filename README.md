dotfiles
========

## Installation

1. Clone this repository into ".dotfiles": `git clone git://github.com/ckoehn/dotfiles.git ~/.dotfiles`
2. Save old configuration files: `mv .gitconfig .gitconfig.old && mv .tmux.conf .tmux.conf.old`
3. Link new configuration files: `ln -sf .dotfiles/git.conf ~/.gitconfig && ln -sf .dotfiles/.gitignore ~/.gitignore && ln -sf .dotfiles/tmux.conf ~/.tmux.conf && ln -sf .dotfiles/bash.conf ~/.bash.conf`
4. Include bash settings: `echo 'if [ -f ~/.bash.conf ]; then . ~/.bash.conf; fi' >> ~/.bashrc`
5. Create local configuration files: `touch ~/.gitconfig.local && touch ~/.tmux.conf.local`
