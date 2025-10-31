# Default programs
export EDITOR="nvim"
export TERMINAL="wezterm"
export TERM="wezterm"
export VISUAL="zeditor"
ZED_ALLOW_ROOT=true
# export BROWSER="librewolf"
export MANPAGER='nvim +Man!' # Visualiza las man-pages, mediante Neovim.
export SHELL="/bin/zsh"

# XDG Paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_SCREENSHOTS_DIR="$HOME/Imágenes/screenshots"
export XDG_RUNTIME_DIR="/run/user/$UID"

# Añadir directorios al PATH.

# export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin:$(print -l $HOME/.local/bin/**/*(/) | tr '\n' ':')$PATH"
#export XDG_DATA_HOME/zed/logs

# ~/ Clean-up:
export PASSWORD_STORE_DIR="$XDG_DATA_HOME/password-store"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export GOPATH="$XDG_DATA_HOME/go"

# /home/kh/.cargo
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# /home/kh/.rustup
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
# /home/kh/.java
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export TEXMFVAR=$XDG_CACHE_HOME/texlive/texmf-var
export TEXMFCONFIG=$XDG_CONFIG_HOME/texlive/texmf-config
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
# /home/kh/.gtkrc-2.0
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
# /home/kh/.npm
export NPM_CONFIG_INIT_MODULE="$XDG_CONFIG_HOME"/npm/config/npm-init.js
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME"/npm
export NPM_CONFIG_TMP="$XDG_RUNTIME_DIR"/npm
# git
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1


# Other programs
# export QT_QPA_PLATFORMTHEME="gtk3"        # Have QT use gtk2 theme.
export _JAVA_AWT_WM_NONREPARENTING=1      # Fix for Java applications in dwm

[ -d "$XDG_CONFIG_HOME"/cargo/env ] || mkdir -p "$XDG_CONFIG_HOME"/cargo/env
. "$XDG_CONFIG_HOME/cargo/env"

# Corregir fonts en ventanas JAVA.
export AWT_FONT_FAMILY='Iosevka Term Nerd Font'
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
export JAVA_TOOL_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'
