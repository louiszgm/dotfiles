#!/bin/bash
#############################################################
# Install Android Dev Env via brew cask
# Author: zouguiming <louiszgm@gmail.com>

参考的链接：https://gist.github.com/cemo/02244e9c2c78e4ea7c285305c16411bf
#############################################################

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

# Cask applications
# why not need ndk, see this: https://github.com/Homebrew/homebrew-cask/issues/58883
caskapps=(
  android-studio
  android-sdk
)

#brew applications
brewapps=(
  gradle
)

function check {
    # Check OS
    if [[ $OSTYPE != darwin* ]]; then
        echo "${RED}Error: only install software via brew_cask on macOS.${NORMAL}" >&2
        exit 1
    fi

    # Check brew
    if ! command -v brew >/dev/null 2>&1; then
        printf "${BLUE} ➜  Installing Homebrew and Cask...${NORMAL}\n"

        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

        brew tap caskroom/cask
        brew tap caskroom/fonts
        cd "$(brew --repo)"/Library/Taps/caskroom/homebrew-cask
        git remote set-url origin https://mirrors.ustc.edu.cn/homebrew-cask.git
    fi
}

function install () {
    for app in ${caskapps[@]}; do
        printf "${BLUE} ➜  Installing ${app}...${NORMAL}\n"
        brew install --cask ${app}
    done

    for brewapp in ${brewapps[@]}; do
        printf "${BLUE} ➜  Installing ${brewapp}...${NORMAL}\n"
        brew install ${brewapp}
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
