#!/bin/sh
#############################################################
# Set development environment on Linux/macOS/Cygwin quickly.
# Author: Vincent Zhang <seagle0128@gmail.com>
# URL: https://github.com/seagle0128/dotfiles
#############################################################

# Variables
DOTFILES=$HOME/.dotfiles
FZF=$HOME/.fzf
TMUX=$HOME/.tmux
ZSH=$HOME/.zinit

# Get OS informatio
OS=`uname -s`
OSREV=`uname -r`
OSARCH=`uname -m`

# Only enable exit-on-error after the non-critical colorization stuff,
# which may fail on systems lacking tput or terminfo
# set -e

# Use colors, but only if connected to a terminal, and that terminal
# supports them.
if command -v tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
fi

# Functions
is_mac()
{
    [ "$OS" = "Darwin" ]
}

is_cygwin()
{
    [ "$OSTYPE" = "cygwin" ]
}

is_linux()
{
    [ "$OS" = "Linux" ]
}

is_debian() {
    command -v apt-get >/dev/null 2>&1
}

is_arch() {
    command -v pacman >/dev/null 2>&1
}

is_x86_64() {
    [ $(uname -m) = "x86_64" ]
}

is_arm64() {
    [ $(uname -m) = "arm64" ]
}

sync_repo() {
    local repo_uri="$1"
    local repo_path="$2"
    local repo_branch="$3"

    if [ -z "$repo_branch" ]; then
        repo_branch="master"
    fi

    if [ ! -e "$repo_path" ]; then
        mkdir -p "$repo_path"
        git clone --depth 1 --branch $repo_branch "https://github.com/$repo_uri.git" "$repo_path"
    else
        cd "$repo_path" && git pull --rebase --stat origin $repo_branch; cd - >/dev/null
    fi
}

install_package() {
    if ! command -v ${1} >/dev/null 2>&1; then
        if is_mac; then
            brew -q install ${1}
        elif is_debian; then
            sudo apt-get install -y ${1}
        elif is_arch; then
            pacman -Ssu --noconfirm ${1}
        elif is_cygwin; then
            apt-cyg install -y ${1}
        fi
    else
        if is_mac; then
            brew upgrade -q ${1}
        elif is_debian; then
            sudo apt-get upgrade -y ${1}
        elif is_arch; then
            pacman -Ssu --noconfirm ${1}
        elif is_cygwin; then
            apt-cyg upgrade -y ${1}
        fi
    fi
}

clean_dotfiles() {
    confs="
    .gemrc
    .gitconfig
    .markdownlintrc
    .npmrc
    .tmux.conf
    .vimrc
    .zshenv
    .zshrc
    .zshrc.local
    starship.toml
    "
    for c in ${confs}; do
        [ -f $HOME/${c} ] && mv $HOME/${c} $HOME/${c}.bak
    done

    if [ -f $HOME/.config/starship.toml ]; then
        mv $HOME/.config/starship.toml $HOME/.config/starship.toml.bak
    fi
    
    rm -rf $ZSH $TMUX $DOTFILES

    rm -f $HOME/.gitignore_global
    rm -f $HOME/.tmux.conf
}

YES=0
NO=1
promote_yn() {
    eval ${2}=$NO
    read -p "$1 [y/N]: " yn
    case $yn in
        [Yy]* )    eval ${2}=$YES;;
        [Nn]*|'' ) eval ${2}=$NO;;
        *)         eval ${2}=$NO;;
    esac
}

# Clean or not?
if [ -d $ZSH ] || [ -d $TMUX ] || [ -d $EMACSD ]; then
    promote_yn "${YELLOW}Do you want to reset all configurations?${NORMAL}" "continue"
    if [ $continue -eq $YES ]; then
        clean_dotfiles
    fi
fi

# Generate locale
if is_linux; then
    locale -a | grep en_US.utf8 > /dev/null || localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
fi

# Install Brew/apt-cyg
if is_mac && ! command -v brew >/dev/null 2>&1; then
    printf "${GREEN}▓▒░ Installing Homebrew...${NORMAL}\n"
    # Install homebrew

    # Use mirror
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_INSTALL_FROM_API=1

    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    /bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@HEAD/install.sh)"

    if is_arm64; then
        echo >> $HOME/.zprofile
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Tap cask-upgrade
    brew tap buo/cask-upgrade

    # Install GNU utilities
    brew install coreutils
elif is_cygwin && ! command -v apt-cyg >/dev/null 2>&1; then
    printf "${GREEN}▓▒░ Installing Apt-Cyg...${NORMAL}\n"
    APT_CYG=/usr/local/bin/apt-cyg
    curl -fsSL https://raw.githubusercontent.com/transcode-open/apt-cyg/master/apt-cyg > $APT_CYG
    chmod +x $APT_CYG
fi

# Check git
if ! command -v git >/dev/null 2>&1; then
    printf "${GREEN}▓▒░ Installing git...${NORMAL}\n"
    install_package git
fi

# Check curl
if ! command -v curl >/dev/null 2>&1; then
    printf "${GREEN}▓▒░ Installing curl...${NORMAL}\n"
    install_package curl
fi

# Check zsh
if ! command -v zsh >/dev/null 2>&1; then
    printf "${GREEN}▓▒░ Installing zsh...${NORMAL}\n"
    install_package zsh
fi

# ZSH plugin manager
printf "${GREEN}▓▒░ Installing Zinit...${NORMAL}\n"
sh -c "$(curl -fsSL https://git.io/zinit-install)"

# Dotfiles
printf "${GREEN}▓▒░ Installing Dotfiles...${NORMAL}\n"
sync_repo louiszgm/dotfiles $DOTFILES

chmod +x $DOTFILES/install.sh
chmod +x $DOTFILES/install_brew_cask.sh
chmod +x $DOTFILES/install_go.sh

ln -sf $DOTFILES/.zshenv $HOME/.zshenv
ln -sf $DOTFILES/.zshrc $HOME/.zshrc
ln -sf $DOTFILES/.vimrc $HOME/.vimrc
ln -sf $DOTFILES/.tmux.conf.local $HOME/.tmux.conf.local
ln -sf $DOTFILES/.markdownlintrc $HOME/.markdownlintrc
ln -sf $DOTFILES/starship.toml $HOME/.config/starship.toml

# 确保目标目录存在
mkdir -p $HOME/.config

# 创建符号链接
ln -sf $DOTFILES/starship.toml $HOME/.config/starship.toml

# 使用兼容选项复制文件
cp -f $DOTFILES/.npmrc $HOME/.npmrc
cp -f $DOTFILES/.gemrc $HOME/.gemrc
mkdir -p $HOME/.cargo && cp -f $DOTFILES/cargo.toml $HOME/.cargo/config.toml
cp -f $DOTFILES/.zshrc.local $HOME/.zshrc.local
mkdir -p $HOME/.pip; cp -f $DOTFILES/.pip.conf $HOME/.pip/pip.conf

cp -f $DOTFILES/.npmrc $HOME/.npmrc
cp -f $DOTFILES/.gemrc $HOME/.gemrc
mkdir -p $HOME/.cargo && cp -f $DOTFILES/cargo.toml $HOME/.cargo/config.toml
cp -f $DOTFILES/.zshrc.local $HOME/.zshrc.local
mkdir -p $HOME/.pip; cp -f $DOTFILES/.pip.conf $HOME/.pip/pip.conf

ln -sf $DOTFILES/.gitignore_global $HOME/.gitignore_global
ln -sf $DOTFILES/.gitconfig_global $HOME/.gitconfig_global
if is_mac; then
    cp -f $DOTFILES/.gitconfig_macOS $HOME/.gitconfig
elif is_cygwin; then
    cp -f $DOTFILES/.gitconfig_cygwin $HOME/.gitconfig
else
    cp -f $DOTFILES/.gitconfig_linux $HOME/.gitconfig
fi

if is_cygwin; then
    ln -sf $DOTFILES/.minttyrc $HOME/.minttyrc
fi

# Packages
printf "${GREEN}▓▒░ Installing packages...${NORMAL}\n"
if is_mac; then
    ./install_brew.sh
elif is_arch; then
    ./install_arch.sh
elif is_debian; then
    ./install_debian.sh
else
    printf "Noting to install!"
fi

# Entering zsh
printf "${GREEN}▓▒░ Done. Enjoy!${NORMAL}\n"
if command -v zsh >/dev/null 2>&1; then
    if is_cygwin && [ "$SHELL" != "$(which zsh)" ]; then
        chsh -s $(which zsh)
        printf "${GREEN} You need to logout and login to enable zsh as the default shell.${NORMAL}\n"
    fi
    env zsh
else
    echo "${RED}Error: zsh is not installed${NORMAL}" >&2
    exit 1
fi
