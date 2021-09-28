#!/usr/bin/env bash

clear
echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
cat /etc/fedora-release | grep "Fedora release 34"
if [[ $? -ne 0 ]]; then
    echo "This script must be run onto a Fedora 34";
    exit 1
fi
echo "Press ENTER to continue..."
read

packages_list=(emacs-nox
               emacs-tuareg)

git clone https://github.com/Epitech/epitech-emacs.git

dnf -y install ${packages_list}

cd epitech-emacs
git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh system
cd .. && rm -rf epitech-emacs

install -m 644 bash_completion.d/blih /usr/share/bash-completion/completions