source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved;
then
	zgen prezto '*:*' case-sensitive 'no'
	zgen prezto '*:*' color 'yes'
	zgen prezto git:alias skip 'yes'
	zgen prezto prompt theme 'sorin'

	zgen prezto
	zgen prezto archive
	zgen prezto git
	zgen prezto syntax-highlighting

	zgen load "${HOME}/.zsettings"

	zgen save
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
