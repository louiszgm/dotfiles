# Zsh configuration

ANTIGEN=$HOME/.antigen
DOTFILES=$HOME/.dotfiles

# Configure Antigen
declare -a ANTIGEN_CHECK_FILES
ANTIGEN_CHECK_FILES=($HOME/.zshrc $HOME/.zshrc.local)

# Load Antigen
if [[ $OSTYPE == darwin* ]]; then
    source /usr/local/share/antigen/antigen.zsh
else
    if command -v apt-get >/dev/null 2>&1; then
        source /usr/share/zsh-antigen/antigen.zsh
    elif command -v yaourt >/dev/null 2>&1; then
        source /usr/share/zsh/share/antigen.zsh
    else
        source $ANTIGEN/antigen.zsh
    fi
fi

# Load the oh-my-zsh's library
antigen use oh-my-zsh

# Tell Antigen that you're done
antigen apply

# Completion enhancements
source $DOTFILES/completion.zsh
