#!/usr/bin/env bash

set -euo pipefail

dotfiles="$HOME/hyprcrow/"

[ -d "$dotfiles" ] || {
	exit 1
}

pkg_zsh=(
	"stow"
	"zsh"
	"git"
	"fzf"
	"zoxide"
	"curl"
	#"oh-my-posh-bin"
	"exa"
	"bat"
	# "pokemon-colorscripts-git"
)

if command -v pacman &>/dev/null; then
	sudo pacman -S --needed --noconfirm "${pkg_zsh[@]}"
fi

[[ ! -f ~/.zshrc ]] || mv ~/.zshrc ~/.zshrc.bak

[[ ! -f $HOME/.zlogin ]] || mv $HOME/.zlogin $HOME/.zlogin.bak

# echo "export ZDOTDIR=$HOME/.config/zsh" >> $HOME/.zlogin # Genera el archivo en el directorio home.

echo 'export XDG_CONFIG_HOME="$HOME/.config"' | sudo tee /etc/zsh/zlogin
echo 'export ZDOTDIR="$XDG_CONFIG_HOME"/zsh' | sudo tee -a /etc/zsh/zlogin

chsh -s $(which zsh)
