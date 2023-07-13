#!/usr/bin/env bash

# Install yay (AUR package manager)
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay
