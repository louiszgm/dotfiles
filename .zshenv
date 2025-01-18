# ZSH envioronment

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM=xterm-256color
export DEFAULT_USER=$USER
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/sbin:$PATH

# Zinit
export PATH=$ZPFX/bin:$PATH

# Cask
export PATH=$HOME/.cask/bin:$PATH

# Golang
export GO111MODULE=auto
export GOPROXY=https://goproxy.io,direct
export GOPATH=$HOME/go
export PATH=${GOPATH//://bin:}/bin:$PATH

# Rust
export PATH=$HOME/.cargo/bin:$PATH

#Python virtualenv
export VIRTUALEVN_ROOT=$HOME/.virtualenvs
export PATH=$VIRTUALEVN_ROOT:$PATH
# ======= This is personal env ================

if [[ $OSTYPE == darwin* ]]; then
    #$(brew --prefix) = /usr/local

    # mac 已经提供/usr/libexec/java_home工具来管理安装的 JDK
    # 通过命令/usr/libexec/java_home -V来查看安装了哪几个 JDK
    # export JAVA_HOME=$(/usr/libexec/java_home -v 13)
    # export PATH=$JAVA_HOME:$JAVA_HOME/bin:$PATH

    #Android 环境变量可参考 https://developer.android.com/studio/command-line/variables
    export STUDIO_JDK=/Applications/Android\ Studio.app/Contents/jre/jdk/Contents/Home
    #Android stuido 默认安装的sdk位置
    export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
    export ANDROID_BUILD_TOOLS=$ANDROID_SDK_ROOT/build-tools/$(ls $ANDROID_SDK_ROOT/build-tools | sort | tail -1)
    export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK_ROOT/platform-tools
    export PATH=$ANDROID_SDK_ROOT:$ANDROID_PLATFORM_TOOLS:$ANDROID_BUILD_TOOLS:$PATH
elif [[ $OSTYPE == linux* ]]; then
    #Linux上的还没有配
    export JAVA_HOME=/usr/bin/java
    export PATH=$JAVA_HOME:$JAVA_HOME/bin:$PATH
    # Android
    export ANDROID_SDK_ROOT=/usr/lib/android-sdk
    export ANDROID_BUILD_TOOLS=$ANDROID_SDK_ROOT/build-tools/$(ls $ANDROID_SDK_ROOT/build-tools | sort | tail -1)
    export ANDROID_PLATFORM_TOOLS=$ANDROID_SDK_ROOT/platform-tools
    export PATH=$ANDROID_SDK_ROOT:$ANDROID_PLATFORM_TOOLS:$ANDROID_BUILD_TOOLS:$PATH
    # Golang 
    #  wget https://dl.google.com/go/go1.13.6.linux-amd64.tar.gz
    #  tar -C /usr/local -xzf go1.13.6.linux-amd64.tar.gz
    export PATH=$PATH:/usr/local/go/bin
fi


#Flutter
export Flutter_HOME=$HOME/flutter
export PATH=$Flutter_HOME:$Flutter_HOME/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH=$HOME/.rvm/bin:$PATH
