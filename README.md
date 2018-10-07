# dotfiles

## Requirements
* [The Silver Searcher](https://github.com/ggreer/the_silver_searcher)
* [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
* `compton`
* `feh`
* `xsel`

## Installation
1. Clone this repository: `git clone git://github.com/ckoehn/dotfiles.git ~/.dotfiles`
2. Install it: `cd .dotfiles && ./install.sh`

## Applications
* Chromium
  * `cp /usr/share/applications/chromium.desktop .local/share/applications`
  * Add `--password-store=gnome` to the `Exec` command
