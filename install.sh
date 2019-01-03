#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

is_linux() {
    [ "$(uname)" == "Linux" ]
}

is_darwin() {
    [ "$(uname)" == "Darwin" ]
}

echo "Installing dotfiles."

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh
tic -x xterm-256color-italic.terminfo

# only perform macOS-specific install
if is_darwin; then
    echo -e "\n\nRunning on OSX"

    if test ! $(which brew); then
        echo "Installing homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi

    source install/brew.sh

    source install/osx.sh

    # create a backup of the original nginx.conf
    if [ -f /usr/local/etc/nginx/nginx.conf ]; then
        mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.original
    fi

    ln -s ~/.dotfiles/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf
    # symlink the code.dev from dotfiles
    ln -s ~/.dotfiles/nginx/code.dev /usr/local/etc/nginx/sites-enabled/code.dev
elif is_linux; then
    echo -e "\n\nRunning on Linux"

    if test ! $(which brew); then
        echo "Installing linuxbrew"
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
    fi

    source install/brew.sh
else
    echo -e "\nUnsupported system $(uname)"
    exit 1
fi


echo "creating vim directories"
mkdir -p ~/.vim-tmp

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
fi

if ! command_exists zplug; then
    echo "installing zplug, a plugin manager for zsh - http://zplug.sh"
    git clone https://github.com/zplug/zplug ~/.zplug
fi

if command_exists rbenv; then
    curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-doctor | zsh
fi

echo "Done. Reload your terminal."
