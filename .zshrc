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

# Bundles from the default repo (robbyrussell's oh-my-zsh)
antigen bundle common-aliases
antigen bundle git
antigen bundle gitfast
antigen bundle colored-man-pages
antigen bundle extract
antigen bundle sudo
antigen bundle z

# Misc bundles.
command -v python >/dev/null 2>&1 && antigen bundle djui/alias-tips

# OS bundles
if [[ $OSTYPE == darwin* ]]; then
    antigen bundle osx
    if command -v brew >/dev/null 2>&1; then
        export HOMEBREW_INSTALL_CLEANUP=1
        alias bu='brew update && brew upgrade'
        alias bcu='brew cu --all --yes --cleanup'
        alias bua='bu && bcu'
    fi
elif [[ $OSTYPE == linux* ]]; then
    if command -v apt-get >/dev/null 2>&1; then
        antigen bundle ubuntu
        alias agua='aguu -y && agar -y && aga -y'
        alias kclean+='sudo aptitude remove -P "?and(~i~nlinux-(ima|hea),\
                            ?not(?or(~n`uname -r | cut -d'\''-'\'' -f-2`,\
                            ~nlinux-generic,\
                            ~n(linux-(virtual|headers-virtual|headers-generic|image-virtual|image-generic|image-`dpkg --print-architecture`)))))"'
    elif command -v pacman >/dev/null 2>&1; then
        antigen bundle archlinux
    fi
fi
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zdharma/fast-syntax-highlighting
# antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-history-substring-search
antigen bundle hlissner/zsh-autopair

# Load the theme.
antigen theme ys            # ys, dst, steeef, wedisagree, robbyrussell

# Local customizations, e.g. theme, plugins, aliases, etc.
[ -f $HOME/.zshrc.local ] && source $HOME/.zshrc.local

# Tell Antigen that you're done
antigen apply

# Completion enhancements
source $DOTFILES/completion.zsh

# Emacs
alias me="emacs -Q --load ~/.emacs.d/init-mini.el" # mini emacs
alias e="$EDITOR -n"
alias ec="$EDITOR -n -c"
alias ef="$EDITOR -c"
alias te="$EDITOR -a '' -nw"
alias rte="$EDITOR -e '(let ((last-nonmenu-event nil) (kill-emacs-query-functions nil)) (save-buffers-kill-emacs t))' && te"