#!/usr/bin/env bash

set -euo pipefail

# Nerdfonts son necesarias.

pkg_nvim=(
	"git"
	"fzf"
	"ripgrep"
	"luarocks"
	"go"
	"npm"
	"neovim"
	"tmux"
)
sudo pacman -S --needed "${pkg_nvim[@]}"
echo """
MASON (Agregar)

LSP:
→ lua-language-server - Lua
→ efm - Servidor multiproposito
→ stylua (Formatter) - Lua
-> pyright - Python
-> typescript-language-server - Typescript Javascript
-> gopls - go
-> bash-language-server (keywords: bash, csh, ksh, sh, zsh)
-> docker-language-server (keywords: docker)
-> clangd (keywords: c, c++)
-> emmet-language-server (keywords: emmet)
-> json-lsp (keywords: json)
-> tailwindcss-language-server (keywords: css)

-> yaml-language-server (keywords: yaml)

Linter:
→ luacheck - Lua
-> flake8 - Python
-> eslint_d - Typescript Javascript
-> revive - go
-> shellcheck - bash
-> hadolint (keywords: docker)
-> cpplint (keywords: c, c++)

Formatter:
→ stylua (LSP) - Lua
-> black - Python
-> prettier - css html json javascript markdown scss typescript yaml
-> fixjson - json
-> gofumpt - go
-> shfmt (keywords: bash, mksh, shell)
-> clang-format (keywords: c, c#, c++, json, java, javascript)
comm -23 <(printf '%s\n' neovim go htop | sort) <(pacman -Qq | sort)
"""
