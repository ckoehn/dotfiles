export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
export FZF_DEFAULT_OPTS='--reverse --height 40% --inline-info --preview-window="right:hidden" --preview "[[ $(file --mime {}) =~ binary ]] && hexyl {} || bat -n --color always {}" --bind="?:toggle-preview"'

export BAT_THEME='gruvbox-dark'

export GOPATH="${HOME}/code/go"
export PATH="${PATH}:${GOPATH}/bin"

export HOMEBREW_PREFIX='/opt/homebrew'
export PATH="${HOMEBREW_PREFIX}/opt/gnu-sed/libexec/gnubin:${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:${PATH}"
