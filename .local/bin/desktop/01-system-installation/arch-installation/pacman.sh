#!/usr/bin/env bash

set -euo pipefail

sudo tee /etc/pacman.conf >/dev/null <<'EOF'
#
# /etc/pacman.conf
#

[options]
HoldPkg     = pacman glibc
Architecture = auto
# IgnorePkg = «PKG»
Color
ILoveCandy
CheckSpace
VerbosePkgLists
ParallelDownloads = 5

SigLevel    = Required DatabaseOptional
LocalFileSigLevel = Optional

[core]
Include = /etc/pacman.d/mirrorlist

[extra]
Include = /etc/pacman.d/mirrorlist
EOF
