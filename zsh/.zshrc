eval "$(/opt/homebrew/bin/brew shellenv)"
source "${HOME}/.zconfig"
export ZPLUG_HOME=$(brew --prefix)/opt/zplug
source $ZPLUG_HOME/init.zsh

zstyle ':prezto:*:*' case-sensitive 'yes'
zstyle ':prezto:*:*' color 'yes'
zstyle ':prezto:module:editor' key-bindings 'vi'
zstyle ':prezto:module:prompt' theme 'sorin'
zstyle ':prezto:module:git:alias' skip 'yes'
zstyle ':prezto:module:utility' safe-ops 'no'

zplug "modules/environment", from:prezto
zplug "modules/terminal", from:prezto
zplug "modules/editor", from:prezto
zplug "modules/history", from:prezto
zplug "modules/directory", from:prezto
zplug "modules/spectrum", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/completion", from:prezto
zplug "modules/prompt", from:prezto

zplug "modules/archive", from:prezto
zplug "modules/git", from:prezto
zplug "modules/python", from:prezto
zplug "modules/syntax-highlighting", from:prezto

zplug "lukechilds/zsh-nvm"
zplug "jonmosco/kube-ps1", use:"kube-ps1.sh"
zplug "${HOME}/.zsettings", from:local

if ! zplug check --verbose; then
	printf "Install? [y/N]: "
	if read -q; then
		echo; zplug install
	fi
fi

zplug load

RPROMPT+=' $(kube_ps1)'

# https://github.com/junegunn/fzf/blob/ab11b74be4b0c9fac88d95f0f563d0dc0cb06ed3/install#L259-L269
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# https://github.com/helm/helm/issues/9251
# helm couldn't install our chart anymore
ulimit -n 1024

# brew: coreutils
PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
