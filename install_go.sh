#!/bin/bash
#############################################################
# Install and update go packages
# Author: Vincent Zhang <seagle0128@gmail.com>
# URL: https://github.com/seagle0128/dotfiles
#############################################################

# Go packages
packages=(
    # Essential
    # golang.org/x/tools/gopls
    # github.com/go-delve/delve/cmd/dlv
    # honnef.co/go/tools/cmd/staticcheck

    golang.org/x/tools/cmd/goimports
    # github.com/aarzilli/gdlv
    github.com/zmb3/gogetdoc
    github.com/josharian/impl
    github.com/cweill/gotests/...
    github.com/fatih/gomodifytags
    github.com/davidrjenni/reftools/cmd/fillstruct
    github.com/google/gops
    github.com/haya14busa/goplay/cmd/goplay
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

YES=0
NO=1
function promote_yn() {
    eval ${2}=$NO
    read -p "$1 [y/N]: " yn
    case $yn in
        [Yy]* )    eval ${2}=$YES;;
        [Nn]*|'' ) eval ${2}=$NO;;
        *)         eval ${2}=$NO;;
    esac
}

function check() {
    if ! command -v go >/dev/null 2>&1; then
        echo "${RED}Error: go is not installed${NORMAL}" >&2
        exit 1
    fi
}

function install() {
    for p in ${packages[@]}; do
        printf "${BLUE} ➜  Installing ${p}...${NORMAL}\n"
        GO111MODULE=on go install ${p}@latest
    done
}

function goclean() {
    rm -rf $GOPATH/src/$1
    rm -rf $GOPATH/pkg/mod/{$1}*
}

function clean() {
    for p in ${packages[@]}; do
        goclean ${p}
    done
}

function main() {
    check
    install
}

main
