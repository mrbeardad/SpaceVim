#!/bin/bash

if [[ "$1" == "-f" ]] ;then
    option="-f"
elif [[ "$1" == "-n" ]] ;then
    option="-n"
else
    option="-i"
fi

cp $option -vu ~/.local/bin/{nop,vim-quickrun}.sh custom/
cp $option -vu ~/.SpaceVim.d/init.toml mode/
