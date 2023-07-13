#!/usr/bin/env bash

clear
echo "INSTALLING PACKAGES FOR EPITECH'S DUMP"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi
if [[ ! -f /etc/arch-release ]]; then
    echo "This script must be run on Arch Linux";
    exit 1
fi
echo "Press ENTER to continue..."
read

# Remove annoying beeeeeeps (pcspkr module)
echo "blacklist pcspkr" | tee -a /etc/modprobe.d/blacklist-pcspkr.conf

# Add Microsoft package repository key
pacman-key --recv-keys EB3E94ADBE1229CF
pacman-key --lsign-key EB3E94ADBE1229CF

# Check if yay is already installed
if ! command -v yay &> /dev/null; then
    echo "yay not found. Installing yay..."
    sudo -u "$SUDO_USER" bash -c "git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si --noconfirm"
    rm -rf yay
fi

# Enable AUR support
sudo -u "$SUDO_USER" yay -Syu --needed --noconfirm

# Google Chrome
sudo -u "$SUDO_USER" yay -S --noconfirm google-chrome

# Update system
pacman -Syu --noconfirm

packages_list=(
    boost
    boost-libs
    cmake
    clang
    cunit
    curl
    discord
    flac
    freetype2
    gcc
    gdb
    git
    glibc
    gmp
    ksh
    libjpeg-turbo
    libvorbis
    sdl2
    ltrace
    make
    nasm
    ncurses
    net-tools
    openal
    python-numpy
    python
    rlwrap
    ruby
    strace
    tar
    tcsh
    tmux
    sudo
    tree
    unzip
    valgrind
    vim
    emacs-nox
    which
    xcb-util-image
    zip
    zsh
    avr-gcc
    qt5-base
    docker
    docker-compose
    jdk-openjdk
    boost
    autoconf
    automake
    tcpdump
    wireshark-qt
    nodejs
    haskell-platform
    go
    systemd
    libgudev
    php
    php-gd
    php-mbstring
    php-sqlite
    php-pear
    php-xml
    php-gettext-gettext
    php-phar-io-version
    php-theseer-tokenizer
    sfml
    csfml
    irrlicht
    rust
    cargo
    mariadb
    x264
    fbida
    lightspark
    lightspark-mozilla-plugin
)

sudo -u "$SUDO_USER" yay -S --noconfirm "${packages_list[@]}"

# Criterion
curl -sSL "https://github.com/Snaipe/Criterion/releases/download/v2.4.0/criterion-2.4.0-linux-x86_64.tar.xz" -o criterion-2.4.0.tar.xz
tar xf criterion-2.4.0.tar.xz
cp -r criterion-2.4.0/* /usr/local/
echo "/usr/local/lib" > /etc/ld.so.conf.d/usr-local.conf
ldconfig
rm -rf criterion-2.4.0.tar.xz criterion-2.4.0/

# Sbt
curl -sSL "https://github.com/sbt/sbt/releases/download/v1.3.13/sbt-1.3.13.tgz" | tar xz
mv sbt /usr/local/share
ln -s '/usr/local/share/sbt/bin/sbt' '/usr/local/bin'

# Gradle
wget https://services.gradle.org/distributions/gradle-7.2-bin.zip
mkdir /opt/gradle && unzip -d /opt/gradle gradle-7.2-bin.zip && rm -f gradle-7.2-bin.zip
echo 'export PATH=$PATH:/opt/gradle/gradle-7.2/bin' >> /etc/profile

# Stack
curl -sSL https://get.haskellstack.org/ | sh

# CONFIG EMACS
git clone https://github.com/Epitech/epitech-emacs.git
cd epitech-emacs
git checkout 278bb6a630e6474f99028a8ee1a5c763e943d9a3
./INSTALL.sh system
cd .. && rm -rf epitech-emacs

# CONFIG VIM
git clone https://github.com/Epitech/vim-epitech.git
cd vim-epitech
git checkout ec936f2a49ca673901d56598e141932fd309ddac
./install.sh
cd .. && rm -rf vim-epitech
