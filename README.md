# Personal Dotfiles

Thanks for:

1. https://seagle0128.github.io/dotfiles/
2. https://github.com/mathiasbynens/

## Prerequisite

- GNU Linux, macOS, Windows, Cygwin
- Git, Zsh/Powershell, curl/wget
- Recommend: GNU Emacs, tmux
- Optional: Vim

## Quickstart

### Linux, macOS and Cygwin

``` shell
sh -c "$(curl -fsSL https://github.com/louiszgm/dotfiles/raw/master/install.sh)"
```

or

``` shell
sh -c "$(wget https://github.com/louiszgm/dotfiles/raw/master/install.sh -O -)"
```

or

``` shell
git clone https://github.com/seagle0128/dotfiles.git ~/.dotfiles  # or download the zip package
cd ~/.dotfiles
./install.sh
```

### Windows (Powershell)

``` powershell
git clone https://github.com/seagle0128/dotfiles.git ~/.dotfiles  # or download the zip package
cd ~/.dotfiles
install_scoop.ps1  # or install_choco.ps1
```

## Docker

``` shell
cd ~/.dotfiles
docker build -t centaur/ubuntu .
docker run -it centaur/ubuntu zsh
```

## Shortcuts

- `Alt-c`: cd into the selected directory.
- `Ctrl-r`: Paste the selected command from history into the command line.
- `Ctrl-t`: Paste the selected file path(s) into the command line.
- `TAB`: To completions.

That's it. Enjoy!

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
# Oh-my-zsh plugin
zinit snippet OMZP::golang
zinit snippet OMZP::python
zinit snippet OMZP::ruby

# Github plugin
zinit light ptavares/zsh-direnv
```

See details on [zinit](https://github.com/zdharma-continuum/zinit).

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

