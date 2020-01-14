# Personal Dotfiles

Thanks for:

1. https://seagle0128.github.io/dotfiles/
2. https://github.com/mathiasbynens/

## Prerequisite

- GNU Linux, macOS, Cygwin
- git, zsh, curl/wget
- Recommend: GNU Emacs, tmux
- Optional: Vim

## Quickstart

Run this command in the console.

``` shell
sh -c "$(curl -fsSL https://github.com/louiszgm/dotfiles/raw/master/install.sh)"
```

or

``` shell
sh -c "$(wget https://github.com/louiszgm/dotfiles/raw/master/install.sh -O -)"
```

## Docker

``` shell
cd ~/.dotfiles
docker build -t centaur/ubuntu .
docker run -it centaur/ubuntu zsh
```

## Customization

### ZSH ENV

Add your zsh environments in `~/.zshenv`. This is recommended by ZSH officially.
For example:

``` shell
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/.rbenv/shims:$PATH
export PYTHONPATH=/usr/local/lib/python2.7/site-packages
```

### ZSH local config

Set your personal zsh configurations in `~/.zshrc.local`. For example:

``` shell
# theme
antigen theme ys            # ys, dst, steeef, wedisagree, robbyrussell

# plugins
antigen bundle python
antigen bundle ruby
```

### Git local config

Set your git configurations in `~/.gitconfig.local`, e.g. user credentials.

``` shell
[commit]
    # Sign commits using GPG.
    # https://help.github.com/articles/signing-commits-using-gpg/
    gpgsign = true

[user]
    name = John Doe
    email = john.doe@example.com
    signingkey = XXXXXXXX
```


## License

[MIT License](https://github.com/ray-g/devstrap/blob/master/LICENSE)

