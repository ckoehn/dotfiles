source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved;
then
	zgen prezto '*:*' case-sensitive 'no'
	zgen prezto '*:*' color 'yes'
	zgen prezto git:alias skip 'yes'
	zgen prezto prompt theme 'sorin'
	zgen prezto ssh load identities 'id_rsa' 'id_rsa_github'

	zgen prezto
	zgen prezto archive
	zgen prezto git
	zgen prezto ssh
	zgen prezto syntax-highlighting

	zgen load "${HOME}/.zsettings"

	zgen save
fi

[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"
