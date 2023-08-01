eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -d ~/.zsettings ]; then
  source ~/.zsettings/env.zsh
  source ~/.zsettings/aliases.zsh
  source ~/.zsettings/functions.zsh
  source ~/.zsettings/keybindings.zsh
fi

if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"
source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh"
