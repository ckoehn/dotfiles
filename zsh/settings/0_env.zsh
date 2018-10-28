export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export FZF_DEFAULT_OPTS='--reverse'

export NVM_DIR="${HOME}/.nvm"
export NVM_LAZY_LOAD=true

export VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'

if [ -n "$DESKTOP_SESSION" ]; then
	eval $(gnome-keyring-daemon --start)
	export SSH_AUTH_SOCK
fi
