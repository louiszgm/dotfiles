#!/bin/bash
#############################################################
# Install macOS via brew cask
# Author: Vincent Zhang <seagle0128@gmail.com>
# URL: https://github.com/seagle0128/dotfiles
#############################################################

# Packages
packages=(
    # modern tools
    # bat #cat 的增强版，支持语法高亮和 Git 集成
    # bottom #系统资源监控工具，类似 top，但界面更现代化。
    # btop 另一个系统监控工具，支持更丰富的图形化界面
    # eza ls 的现代替代品，支持图标、颜色和更多信息
    git-delta
    #duf
    #dust
    fd
    fzf
    #gitui
    gping
    #hyperfine
    #neofetch
    #procs
    ripgrep
    #sd
    starship
    tealdeer
    zoxide
)

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

function check {
    # Check OS
    if [[ $OSTYPE != darwin* ]]; then
        echo "${RED}Error: only install software via brew on macOS.${NORMAL}" >&2
        exit 1
    fi

    # Check brew
    if ! command -v brew >/dev/null 2>&1; then
        printf "${BLUE} ➜  Installing Homebrew...${NORMAL}\n"

        xcode-select --install
        /bin/bash -c "$(curl -fsSL https://cdn.jsdelivr.net/gh/Homebrew/install@HEAD/install.sh)"

        if is_arm64; then
            echo >> $HOME/.zprofile
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        fi
    fi
}

function install () {
    for app in ${packages[@]}; do
        printf "${BLUE} ➜  Installing ${app}...${NORMAL}\n"
        brew install -q ${app}
    done
}

function cleanup {
    brew cleanup
}

function main {
    check
    install
    cleanup
}

main
