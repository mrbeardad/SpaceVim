#!/bin/bash

set -e

function backup() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: backup() required one parameter\033[m"
        exit 1
    elif [[ -e "$1" ]] ;then
        mv "$1" "$1".bak
    fi
}

function makedir() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: makedir() required one parameter\033[m"
        exit 1
    elif [[ ! -d "$1" ]] ;then
        if [[ -e "$1" ]] ;then
            mv "$1" "$1".bak
        fi
        mkdir -p "$1"
    fi
}

# 下载仓库配置
if [[ ! -e ~/.SpaceVim ]] ;then
    git clone --depth=1 https://github.com/mrbeardad/SpaceVim ~/.SpaceVim
else
    echo -e "\033[33m~/.SpaceVim\033[m directory is exists, skip 'git clone'"
fi

# 安装init.toml
makedir ~/.SpaceVim.d
backup ~/.SpaceVim.d/init.toml
cp -v ~/.SpaceVim/mode/init.toml ~/.SpaceVim.d

# 安装配置需要的命令
makedir ~/.local/bin
cp ~/.SpaceVim/custom/{vim-quickrun,nop}.sh ~/.local/bin
g++ -O3 -std=c++17 -o ~/.local/bin/quickrun_time ~/.SpaceVim/custom/quickrun_time.cpp

# 链接nvim配置
makedir ~/.config
backup ~/.config/nvim
ln -s ~/.SpaceVim ~/.config/nvim

makedir ~/.local/share/fonts/NerdCode
(
    cd ~/.local/share/fonts/NerdCode || exit 1
    curl -o ~/Downloads/NerdCode.tar.xz https://github.com/mrbeardad/DotFiles/raw/master/fonts/NerdCode.tar.xz
    tar -Jxvf ~/Downloads/NerdCode.tar.xz
    echo -e "\032[32mInstalling NerdCode fonts ...\032[m"
    mkfontdir
    mkfontscale
    fc-cache -f
)

echo -e "\033[32m [Note]:\033[m Now, startup your neovim and execute command \036[36m:SPInstall\036[m to install all plugins.
When all the plug-ins are installed, you need to do one things following :
\033[33mcp -f ~/.SpaceVim/custom/*.vim ~/.cache/vimfiles/repos/github.com/dense-analysis/ale/ale_linters/cpp/
    \033[38;5;249m# This is to make ALE work better with cppcheck and clang-tidy"
