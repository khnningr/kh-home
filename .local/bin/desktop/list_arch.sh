#!/usr/bin/env bash

set -euo pipefail

# Apariencia

pkg_thunar=(
	"xdg-user-dirs"
	"thunar"
	"file-roller"
	"gvfs"
	"gvfs-mtp"
	"thunar-archive-plugin"
	"thunar-media-tags-plugin"
	"thunar-volman"
	"tumbler"
	"ffmpegthumbnailer"
	"libgsf"
)

pkg_gtk=(
	"polkit-gnome"
	"pavucontrol"
	"fragments"
	"foliate"
	"mission-center"
	"evince"
	"gnome-calculator"
	"loupe"
)

pkg_dolphin=(
	"dolphin"
	"ark"
	"archlinux-xdg-menu"
)

# sudo pacman -S --needed --noconfirm "${pkg_dolphin[@]}"

pkg_kde=(
	"polkit-kde-agent"
	"qbittorrent"
	"pavucontrol-qt"
	"gwenview"
	"okular"
	"kdenlive"
	"kcalc"
)

# sudo pacman -S --needed --noconfirm "${pkg_kde[@]}"

# Juegos

pkg_proton_aur=(
	"protonfixes"
)

# paru -S --needed --noconfirm "${pkg_proton_aur[@]}"

# Para usar mango en Steam, usar el comando: 'mangohud %command%'
# Referencias: https://github.com/flightlessmango/MangoHud

# Navegadores
pkg_browser=(
	"vivaldi"
)

# Referencias: https://wiki.archlinux.org/title/Vivaldi

# Social
pkg_msg=(
	"telegram-desktop"
	"vesktop"
)

pkg_android=(
	"android-tools"
)

pkg_openrazer=(
	"linux-zen-headers"
	"openrazer-daemon"
)

pkg_openrazer_aur=(
	"razercommander"
	"polychromatic"
)

# Referencias: https://openrazer.github.io/

pkg_ckb_next=(
	"base-devel"
	"cmake"
	"libsystemd"
	"qt5-base"
	"zlib"
	"libdbusmenu-qt5"
	"quazip"
	"libpulse"
	"qt5-tools"
	"libxcb"
	"xcb-util-wm"
	"qt5-x11extras"
	"git"
	"ckb-next"
)

# Referencias: https://github.com/ckb-next/ckb-next?tab=readme-ov-file

pkg_waybar=(
	"waybar"
	"swaync"
	"blueman"
	"power-profiles-daemon"
)

pkg_rofi=(
	"rofi-wayland"
	"rofi-emoji"
)

pkg_yazi=(
	"yazi"
	"ffmpeg"
	"ffmpegthumbnailer"
	"p7zip"
	"jq"
	"poppler"
	"fd"
	"ripgrep"
	"fzf"
	"zoxide"
	"imagemagick"
	"xdg-desktop-portal"
	"git"
	"libinih"
	"ninja"
	"meson"
	"scdoc"
	"dragon-drop-git"
	"ouch"
)

pkg_yazi_aur=(
	"xdg-desktop-portal-termfilechooser-hunkyburrito-git"
)

# Services

pkg_nm=(
	"networkmanager"
	"network-manager-applet"
	"nm-connection-editor"
)

# sudo pacman -S --needed --noconfirm "${pkg_nm[@]}"

# Firewall
pkg_ufw=(
	"ufw"
	"ufw-extras"
)

pkg_ufw_aur=(
	"ufw-docker-git"
)

# sudo pacman -S --needed --noconfirm "${pkg_ufw_aur[@]}"

# IDE
pkg_java=(
	"jdk-openjdk"
)

# sudo pacman -S --needed --noconfirm "${pkg_java[@]}"

pkg_python_aur=(
	"idle"
)

# paru -S --needed --noconfirm "${pkg_python_aur[@]}"

pkg_virt_manager=(
	"virt-manager"
	"qemu-full"
	"vde2"
	"virt-viewer"
	"ebtables"
	"iptables"
	"dnsmasq"
	"bridge-utils"
	"ovmf"
	"swtpm"
	"dmidecode"
	"qemu-common"
	"libvirt"
)

pkg_mimetype=(
	"xdg-utils"
	"plocate" # locate -i «programa»
)
