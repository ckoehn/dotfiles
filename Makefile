STOW_FLAGS = --verbose=1

.PHONY: brew
brew:
	brew bundle

.PHONY: git
git:
	stow git $(STOW_FLAGS)
	touch ~/.gitconfig.local

.PHONY: vim
vim:
	stow vim $(STOW_FLAGS)
	vim +PlugInstall +qall

.PHONY: k9s
k9s:
	stow k9s $(STOW_FLAGS)

.PHONY: zprezto
zplug:
	-[ ! -d ~/.zprezto ] && git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

.PHONY: zsh
zsh: zprezto
	stow zsh $(STOW_FLAGS)

.PHONY: gpg
gpg:
	mkdir -v -p -m 700 ~/.gnupg
	stow gnupg $(STOW_FLAGS)
