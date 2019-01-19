source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved;
then
	zgen prezto '*:*' case-sensitive 'no'
	zgen prezto '*:*' color 'yes'
	zgen prezto git:alias skip 'yes'
	zgen prezto prompt theme 'sorin'
	zgen prezto editor key-bindings 'vi'

	zgen prezto
	zgen prezto archive
	zgen prezto git
	zgen prezto python
	zgen prezto syntax-highlighting

	zgen load "${HOME}/.zsettings"
	zgen load lukechilds/zsh-nvm

	zgen save
fi

[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"

bindkey jj vi-cmd-mode
