#!/bin/bash

function backup() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError:backup(): required one parameter\033[m"
        exit 1
    elif [[ ! -e "$1" ]] ;then
        echo -e "\033[31mError:backup(): file $1 does not exist\033[m"
        exit 1
    fi
    backFileName="$1"
    while [[ -e "$backFileName" ]] ;do
        backFileName+=$RANDOM
    done
    mv -v "$1" "$backFileName"
}

function makedir() {
    if [[ -z "$1" ]] ;then
        echo -e "\033[31mError: makedir() required one parameter\033[m"
        exit 1
    elif [[ ! -d "$1" ]] ;then
        if [[ -e "$1" ]] ;then
            backup "$1"
        fi
        mkdir -p "$1"
    fi
}

# 下载仓库配置
backup ~/.SpaceVim
git clone --depth=1 https://github.com/mrbeardad/SpaceVim ~/.SpaceVim

# 安装init.toml
backup ~/.SpaceVim.d/
ln -svf ~/.SpaceVim/mode ~/.SpaceVim.d

# 安装配置需要的命令
makedir ~/.local/bin
g++ -O3 -std=c++17 -o ~/.local/bin/quickrun_time ~/.SpaceVim/custom/quickrun_time.cpp

# 链接nvim配置
makedir ~/.config
backup ~/.config/nvim
ln -s ~/.SpaceVim ~/.config/nvim

echo -e "\033[32m [Note]:\033[m Now, startup your neovim and execute command \033[36m:SPInstall\033[m to install all plugins.
When all the plug-ins are installed, you need to do one things following :
\033[38;5;249m# install YCM
\033[33mcd ~/.cache/vimfiles/repos/github.com/ycm-core/YouCompleteMe/ && ./install.py --clangd-completer"
