# source .zshrc - comando para resetear la configuración del shell.

# Add useful functions
source "$ZDOTDIR/zsh-functions"

# Add the usual stuff
zsh_add_file "zsh-aliases"
zsh_add_file "zsh-prompt"

if [ -n "$TTY" ]; then
  export GPG_TTY=$(tty)
else
  export GPG_TTY="$TTY"
fi

[ -d "$HOME"/.clone ] || mkdir -p "$HOME"/.clone
[ -d "$HOME"/.local ] || mkdir -p "$HOME"/.local
[ -d "$HOME"/.local/bin ] || mkdir -p "$HOME"/.local/bin
[ -d "$XDG_STATE_HOME"/fonts ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CONFIG_HOME"/cargo/env ] || mkdir -p "$XDG_CONFIG_HOME"/cargo/env

# Use XDG dirs for completion and history files
[ -d "$XDG_STATE_HOME"/zsh ] || mkdir -p "$XDG_STATE_HOME"/zsh
[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh

# Ubicación del gestor de plugins, zinit y los plugins.
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
# Se le conoce a "${XDG_DATA_HOME:-${HOME}/.local/share}", como 'Parameter
# Expansion' y me permite definir una nueva variable de entorno.
#
# '${XDG_DATA_HOME}' - es una variable de entorno que, si está definida,
# contendrá la ruta a un directorio específico donde se almacenan los
# datos de usuario.
#
# ':-' - es un operador de sustitución de parámetros en Bash. Significa
# "si la variable no está definida o está vacía, usa el valor que sigue
# a este operador". En este caso, si XDG_DATA_HOME no está definida, se
# utilizará el valor predeterminado que sigue, ${HOME}/.local/share.

# Descarga Zinit en caso de que no exista.
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$dirname $ZINIT_HOME"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/carga zinit
source "${ZINIT_HOME}/zinit.zsh"
# 'zinit zstatus' - comando para ver el estatus de zinit.

# Añadir ZSH plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Añadir snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Cargar referencias de autocompletado de zsh-completions.
autoload -Uz compinit # && compinit
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-$ZSH_VERSION

zinit cdreplay -q



# Keybindings
bindkey -e
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey '^[w' kill-region

# Historial
HISTSIZE=5000
# HISTFILE=~/.zsh_history
HISTFILE="$XDG_STATE_HOME"/zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(fzf --zsh)" # <CTRL>R.
eval "$(zoxide init --cmd cd zsh)"
# eval "$(zellij setup --generate-auto-start zsh)"
# 'zellij list-sessions' - lista todas las sesiones.
# 'zellij a «NOMBRE SESIÓN»' - abre una sesión en concreto.
# 'zellij kill-all-sessions' - cierra todas las sesiones.



# Paleta de colores, para los terminales.
#source ~/.local/bin/variables.sh
#sh ~/.local/bin/terminal.sh

#pokemon-colorscripts --no-title -r 1,3,6
#


install_nerd_font "IosevkaTerm"
install_nerd_font "Mononoki"
install_nerd_font "JetBrainsMono"
