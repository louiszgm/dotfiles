#!/bin/bash
#############################################################
# Install Android Dev Env in ubuntu
# Author: zouguiming <louiszgm@gmail.com>

#############################################################

# Get OS name
SYSTEM=`uname -s`

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

# applications
# why not need ndk, see this: https://github.com/Homebrew/homebrew-cask/issues/58883
apps=(
  android-sdk
)


function check {
    if ! command -v git >/dev/null 2>&1; then
        echo "${RED}Error: git is not installed${NORMAL}" >&2
        exit 1
    fi

    if command -v apt >/dev/null 2>&1; then
        APT=apt
    elif command -v apt-get >/dev/null 2>&1; then
        APT=apt-get
    fi

    if [ ! "$SYSTEM" = "Linux" ] || [ -z "$APT" ]; then
        echo "${RED}Error: Not Ubuntu or its derived edition${NORMAL}" >&2
        exit 1
    fi
}

function install () {

    for app in ${apps[@]}; do
        printf "${BLUE} ➜  Installing ${brewapp}...${NORMAL}\n"
        sudo apt upgrade -y ${app}
    done
}

function updateSdk () {
    touch ~/.android/repositories.cfg
    yes | sdkmanager --licenses
    sdkmanager --update
    sdkmanager --install emulator
    sdkmanager --install platform-tools
    sdkmanager --install 'system-images;android-29;google_apis_playstore;x86_64'
    sdkmanager --install 'extras;intel;Hardware_Accelerated_Execution_Manager'
    sdkmanager --install 'build-tools;29.0.2'
    sdkmanager --install 'platforms;android-29' 'platforms;android-28'
    sdkmanager --list
}

function cleanup {
    brew cleanup
}

function main {
    check
    install
    updateSdk
    cleanup
}

main