source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved;
then
	zgen prezto '*:*' case-sensitive 'no'
	zgen prezto '*:*' color 'yes'
	zgen prezto git:alias skip 'yes'
	zgen prezto prompt theme 'sorin'
	zgen prezto gpg-agent ssh-support 'yes'
	zgen prezto ssh load identities 'id_rsa' 'id_rsa_github'

	zgen prezto
	zgen prezto archive
	zgen prezto git
	zgen prezto gpg
	zgen prezto ssh
	zgen prezto syntax-highlighting

	zgen load "${HOME}/.zsettings"
	zgen load lukechilds/zsh-nvm

	zgen save
fi

[ -f "${HOME}/.fzf.zsh" ] && source "${HOME}/.fzf.zsh"
