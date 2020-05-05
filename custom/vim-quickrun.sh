#!/bin/bash -e

# 创建临时目录。存放编译的二进制文件
if [[ ! -d /tmp/QuickRun ]] ;then
    mkdir /tmp/QuickRun
fi

# 创建cgroup资源管理组，限制内存的使用
if [[ ! -d /sys/fs/cgroup/memory/test ]] ;then
    sudo mkdir /sys/fs/cgroup/memory/test
fi
echo $$ | sudo tee /sys/fs/cgroup/memory/test/cgroup.procs > /dev/null
echo 500M | sudo tee /sys/fs/cgroup/memory/test/memory.limit_in_bytes > /dev/null
echo 500M | sudo tee /sys/fs/cgroup/memory/test/memory.memsw.limit_in_bytes > /dev/null

# $1 为 "-r" 时直接运行，剩余参数为quickrun_time的参数
# $1 为 "-c" 时编译并运行，且 $2 为编译选项，$3 源文件，$4 目标文件
# $1 为 "-C" 时编译C++的TU，其它同上
if [[ "$1" == "-r" ]] ;then
    echo -e "\033[1;33m[Note]: Neither the buffer nor the file timestamp has changed. Rerunning last compiled program!\033[m"
    shift 1
elif [[ "$1" == "-c" ]] ;then
    echo -e "\033[1;32m[Compile]\033[34m gcc \033[35m$2\033[34m -O2 -I. -o \033[m$4 \033[3;32m'%'\033[m"
    gcc "$2" -O2 -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -I. -o "$4" "$3"
    shift 3
elif [[ "$1" == "-C" ]] ;then
    echo -e "\033[1;32m[Compile]\033[34m g++ \033[35m$2\033[34m -O2 -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -I. -o \033[m$4 \033[3;32m'%'\033[m"
    g++ "$2" -O2 -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -I. -o "$4" "$3"
    shift 3
else
    echo -e "\033[1;31moption error\033[m"
fi

redirect=${*//</[31m<[m}
redirect=${redirect//>/[31m>[m}
echo -e "\033[1;32m[Running]\033[34m $redirect\033[m"

echo -e "\n[31m--[34m--[35m--[33m--[32m--[36m--[37m--[36m--[32m--[33m--[35m--[34m--[31m--[34m--[35m--[33m--[32m--[36m--[37m--[36m--[32m--[33m--[35m--[34m--[31m--[34m--[35m--[33m--[32m--[36m--[37m--[36m--[32m--[33m--[m"

# $* 与 $@ 中的特殊字符会被转义，"$@" 中字符会被分割为原始字符串(相当于用"'$1' '$2' '$3'")，"$*" 相当于"$1 $2"
bash -c "quickrun_time $*"
echo -e "\033[38;5;242m"

