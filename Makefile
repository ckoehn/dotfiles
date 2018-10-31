STOW_FLAGS = --verbose=1

.PHONY: install
install: zsh git vim terminator fonts i3

.PHONY: x
x:
	stow x $(STOW_FLAGS)

.PHONY: dunst
dunst:
	stow dunst $(STOW_FLAGS)

.PHONY: rofi
rofi:
	stow rofi $(STOW_FLAGS)

.PHONY: polybar
polybar:
	stow polybar $(STOW_FLAGS)

.PHONY: i3
i3: x dunst rofi polybar
	stow i3 $(STOW_FLAGS)

.PHONY: git
git:
	stow git $(STOW_FLAGS)
	touch ~/.gitconfig.local

.PHONY: fzf
fzf:
	-[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf --depth 1
	~/.fzf/install --no-update-rc --completion --key-bindings --no-bash --64

.PHONY: vim
vim: fzf
	stow vim $(STOW_FLAGS)
	vim +PlugInstall +qall

.PHONY: terminator
terminator:
	stow terminator $(STOW_FLAGS)

.PHONY: fonts
fonts:
	stow fonts $(STOW_FLAGS)
	fc-cache -f

.PHONY: zsh
zsh: fzf
	stow zsh $(STOW_FLAGS)
	-[ ! -d ~/.zgen ] && git clone https://github.com/tarjoilija/zgen.git ~/.zgen --depth 1
	chsh -s /usr/bin/zsh
