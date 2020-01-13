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

if [[ $OSTYPE == darwin* ]]; then
    #$(brew --prefix) = /usr/local

    #mac 已经提供/usr/libexec/java_home工具来管理安装的 JDK
    export JAVA_HOME=/usr/libexec/java_home -v 1.13
    export PATH=$JAVA_HOME:$JAVA_HOME/bin:$PATH

    #Android 环境变量可参考 https://developer.android.com/studio/command-line/variables
    export STUDIO_JDK=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
    export ANDROID_SDK_ROOT=/usr/local/share/android-sdk
    export ANDROID_BUILD_TOOLS=$ANDROID_SDK_ROOT/build-tools/$(ls $ANDROID_SDK_ROOT/build-tools | sort | tail -1)
    export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK_ROOT/platform-tools
    export PATH=$ANDROID_SDK_ROOT:$ANDROID_PLATFORM_TOOLS:$ANDROID_BUILD_TOOLS:$PATH
elif [[ $OSTYPE == linux* ]]; then
    #Linux上的还没有配
    export JAVA_HOME=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
    export PATH=$JAVA_HOME:$JAVA_HOME/bin:$PATH
    # Android
    export ANDROID_HOME=$HOME/Library/Android/sdk
    export ANDROID_TOOLS=$ANDROID_HOME/tools
    export ANDROID_PLATFORM_TOOLS=$ANDROID_HOME/platform-tools
    export PATH=$ANDROID_HOME:$ANDROID_TOOLS:$ANDROID_PLATFORM_TOOLS:$PATH
fi


#Flutter
export Flutter_HOME=$HOME/flutter
export PATH=$Flutter_HOME:$Flutter_HOME/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH=$HOME/.rvm/bin:$PATH
