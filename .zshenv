# ZSH envioronment

export LANG="en_US.UTF-8"
export TERM=xterm-256color
export DEFAULT_USER=$USER
export EDITOR='emacsclient -a "emacs"'
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH

# Cask
export PATH=$HOME/.cask/bin:$PATH

# Ruby
export PATH=$HOME/.rbenv/shims:$PATH

# FZF
export PATH=$HOME/.fzf/bin:$PATH

# Golang
export GO111MODULE=on
export GOPROXY=https://goproxy.cn # https://athens.azurefd.net
export GOPATH=$HOME/go
export PATH=${GOPATH//://bin:}/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH
# ======= This is personal env ================
# Android
export ANDROID_HOME=$HOME/Library/Android/sdk:$PATH
export ANDROID_TOOLS=$ANDROID_HOME/tools:$PATH
export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools:$PATH

#Java
export JAVA_HOME=/Applications/Android Studio.app/Contents/jre/jdk/Contents/Home:$PATH
export PATH=$JAVA_HOME/bin:$PATH

#Flutter
export Flutter_HOME=$HOME/flutter:$PATH
export PATH=$Flutter_HOME/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH=$HOME/.rvm/bin:$PATH