#!/usr/bin/env bash

# $1: 编译命令，若为-则提示无需编译，若为空则忽略编译
# $2: 运行命令
# $3: 内存大小限制，默认500M

set -e

# 编译
if [[ -n "$1" ]] ;then
    if [[ "$1" == '-' ]] ;then
        echo -e "\e[1;33m[Note]: Neither the buffer nor the file timestamp has changed. Rerunning last compiled program!\e[m"
    else
        echo -e "\e[1;32m[Compile] \e[34m${1%% *} \e[m${1#* }"
        eval "$1"
    fi
fi

# 配置CGroup
if [[ -n "$3" ]] ;then
    memlimit="$3"
else
    memlimit=500M
fi
if [[ ! -d /sys/fs/cgroup/memory/quickrun ]] ;then
    sudo mkdir /sys/fs/cgroup/memory/quickrun
fi
echo $$ | sudo tee /sys/fs/cgroup/memory/quickrun/cgroup.procs > /dev/null;
echo "$memlimit" | sudo tee /sys/fs/cgroup/memory/quickrun/memory.limit_in_bytes > /dev/null;
echo "$memlimit" | sudo tee /sys/fs/cgroup/memory/quickrun/memory.memsw.limit_in_bytes > /dev/null;

# 运行
if [[ -n "$2" ]] ;then
    echo -e "\e[1;32m[Running] \e[34m${2%% *} \e[m${2#* }"
    echo -e "\n\e[31m---\e[33m---\e[32m---\e[m---\e[36m---\e[34m---\e[35m---\e[34m---\e[36m---\e[m---\e[32m---\e[33m---\e[31m---\e[33m---\e[32m---\e[m---\e[36m---\e[34m---\e[35m---\e[34m---\e[36m---\e[m---\e[32m---\e[33m---\e[31m---\e[m"
    eval "quickrun_time $2"
fi

echo -e "\n\e[38;5;242mPress any keys to close terminal or press <ESC> to avoid close it ..."
