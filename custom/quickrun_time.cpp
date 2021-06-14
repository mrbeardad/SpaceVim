/************************************************
 * quickrun_time.cpp -- Stopwatch
 * Copyright (c) 2020 Heachen Bear
 * Author: Heachen Bear < mrbeardad@qq.com >
 * License: Apache
 ************************************************/

#include <fcntl.h>
#include <signal.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

#include <array>
#include <chrono>
#include <iomanip>
#include <iostream>
#include <string>

namespace ch = std::chrono;

namespace {

const char* SignalNames[NSIG + 4] = {
    "EXIT",
    "SIGHUP",
    "SIGINT",
    "SIGQUIT",
    "SIGILL",
    "SIGTRAP",
    "SIGABRT",
    "SIGBUS",
    "SIGFPE",
    "SIGKILL",
    "SIGUSR1",
    "SIGSEGV",
    "SIGUSR2",
    "SIGPIPE",
    "SIGALRM",
    "SIGTERM",
    "SIGSTKFLT",
    "SIGCHLD",
    "SIGCONT",
    "SIGSTOP",
    "SIGTSTP",
    "SIGTTIN",
    "SIGTTOU",
    "SIGURG",
    "SIGXCPU",
    "SIGXFSZ",
    "SIGVTALRM",
    "SIGPROF",
    "SIGWINCH",
    "SIGIO",
    "SIGPWR",
    "SIGSYS",
    "SIGJUNK(32)",
    "SIGJUNK(33)",
    "SIGRTMIN",
    "SIGRTMIN+1",
    "SIGRTMIN+2",
    "SIGRTMIN+3",
    "SIGRTMIN+4",
    "SIGRTMIN+5",
    "SIGRTMIN+6",
    "SIGRTMIN+7",
    "SIGRTMIN+8",
    "SIGRTMIN+9",
    "SIGRTMIN+10",
    "SIGRTMIN+11",
    "SIGRTMIN+12",
    "SIGRTMIN+13",
    "SIGRTMIN+14",
    "SIGRTMIN+15",
    "SIGRTMAX-14",
    "SIGRTMAX-13",
    "SIGRTMAX-12",
    "SIGRTMAX-11",
    "SIGRTMAX-10",
    "SIGRTMAX-9",
    "SIGRTMAX-8",
    "SIGRTMAX-7",
    "SIGRTMAX-6",
    "SIGRTMAX-5",
    "SIGRTMAX-4",
    "SIGRTMAX-3",
    "SIGRTMAX-2",
    "SIGRTMAX-1",
    "SIGRTMAX",
    "DEBUG",
    "ERR",
    "RETURN",
    nullptr
};


std::pair<int, int> fork_and_exec(char* const argv[]) noexcept
{
    auto pid = ::fork();
    if ( pid == -1 ) {
        std::perror("QuickRun Error in fork()");
        std::exit(EXIT_FAILURE);
    } else if ( pid == 0 ) {
        // 子进程独立PGID
        ::setpgid(0, 0);

        // 讲子进程设置为前台进程组
        auto origHandle = ::signal(SIGTTOU, SIG_IGN);
        ::tcsetpgrp(STDIN_FILENO, ::getpgid(0));
        ::signal(SIGTTOU, origHandle);

        if ( ::execvp(argv[0], argv) == -1 ) {
            std::perror("QuickRun Error in execvp()");
            std::exit(EXIT_FAILURE);
        }
    }
    // 等待子进程退出
    int status;
    ::wait(&status);

    // 恢复前台进程组
    auto origHandle = ::signal(SIGTTOU, SIG_IGN);
    ::tcsetpgrp(STDIN_FILENO, ::getpgid(0));
    ::signal(SIGTTOU, origHandle);

    return {status, pid};
}

} // namespace


int main(int argc, char* argv[])
{
    if ( argc < 2 ) {
        std::cerr << "quickrun_time: you must give at least one parameter to this program";
        exit(EXIT_FAILURE);
    }

    // 执行子进程并计时
    auto runtimeBegin = ch::steady_clock::now();
    auto statusAndPid = ::fork_and_exec(argv + 1);
    auto& status = statusAndPid.first;
    auto& pid = statusAndPid.second;
    auto runtimeLen = ch::duration_cast<ch::microseconds>(ch::steady_clock::now() - runtimeBegin);

    std::string exitString;
    if ( WIFEXITED(status) ) { // 子进程正常退出
        auto exitCode = WEXITSTATUS(status);
        if ( exitCode == 0 ) {
            exitString = "\033[1;32mcode=0\033[m";
        } else {
            exitString = "\033[1;33mcode=" + std::to_string(exitCode) + "\033[m";
        }
    } else if ( WIFSIGNALED(status) ) { // 子进程因接收到信号而被强制停止
        int signalNum{WTERMSIG(status)};
        exitString = "\033[1;31mSignal=" + std::to_string(signalNum) + ' ' + ::SignalNames[signalNum] + ' ' + "\033[m";
    }

    std::cout << "\n\033[32m[END]\033[m process \033[35m" << pid << "\033[m exit with " << exitString;

    constexpr auto MSECOND = 1000;
    constexpr auto SECOND = 1000000;
    constexpr auto MIN = SECOND * 60;
    constexpr auto HOUR = MIN * 60L;
    auto useconds = runtimeLen.count();
    std::cout << std::setprecision(3) << std::fixed << " in \033[36m";
    if ( useconds < SECOND ) { // 小于1s则用ms做单位
        std::cout << useconds / static_cast<double>(MSECOND) << " ms";
    } else if ( useconds < MIN ) {
        std::cout << useconds / static_cast<double>(SECOND) << " s";
    } else if ( useconds < HOUR ) {
        std::cout << useconds / MIN << " min "
            << useconds % MIN / static_cast<double>(SECOND) << " s";
    } else {
        std::cout << useconds / HOUR << " h "
            << useconds % HOUR / MIN << " min "
            << useconds % HOUR % MIN / static_cast<double>(SECOND) << " s";
    }

    std::cout << "\033[m" << std::endl;



    return 0 ;
}

