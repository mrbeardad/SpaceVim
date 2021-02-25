/************************************************
 * quickrun_time.cpp -- Stopwatch
 * Copyright (c) 2020 Heachen Bear
 * Author: Heachen Bear < mrbeardad@qq.com >
 * License: Apache
 ************************************************/

#include <array>
#include <chrono>
#include <csignal>
#include <fcntl.h>
#include <iomanip>
#include <iostream>
#include <string>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

namespace ch = std::chrono;

namespace
{
    std::array Signal{
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
        "SIGSYS"
    };


    int fork_and_exec(char* const argv[]) noexcept
    {
        auto pid = fork();
        if ( pid == -1 ) {
            std::perror("QuickRun Error in fork()");
            exit(EXIT_FAILURE);
        } else if ( pid == 0 ) {
            // 讲子进程设置为前台进程组
            auto origHandle = signal(SIGTTOU, SIG_IGN);
            setpgid(0, 0);
            tcsetpgrp(STDIN_FILENO, getpgid(0));
            signal(SIGTTOU, origHandle);

            if ( execvp(argv[0], argv) == -1 ) {
                std::perror("QuickRun Error in execvp()");
                std::exit(EXIT_FAILURE);
            }
        }
        int status{};
        wait(&status);

        // 恢复前台进程组
        auto origHandle = signal(SIGTTOU, SIG_IGN);
        tcsetpgrp(STDIN_FILENO, getpgid(0));
        signal(SIGTTOU, origHandle);

        return status;
    }
} // namespace


int main(int argc, char* argv[])
{
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

    if ( argc < 2 ) {
        std::cerr << "quickrun_time: you must give at least one parameter to this program";
        exit(1);
    }

    // 执行子进程并计时
    auto runtimeBegin = ch::steady_clock::now();
    auto status = fork_and_exec(argv + 1);
    auto runtimeLen = ch::duration_cast<ch::microseconds>(ch::steady_clock::now() - runtimeBegin);

    std::string exitString{};
    if ( WIFEXITED(status) ) { // 子进程正常退出
        if ( auto exitCode = WEXITSTATUS(status); exitCode == 0 ) {
            exitString = "\033[1;32mcode=0\033[m";
        } else {
            exitString = "\033[1;33mcode=" + std::to_string(exitCode) + "\033[m";
        }
    } else if ( WIFSIGNALED(status) ) { // 子进程因接收到信号而被强制停止
        int signalNum{ WTERMSIG(status) };
        exitString = "\033[1;31mSignal=" + std::to_string(signalNum) + ' ' + Signal[signalNum - 1] + ' ' + "\033[m";
    }

    auto runtimeLenCnt = runtimeLen.count();
    auto timeLen = runtimeLenCnt > 1e6 ? runtimeLenCnt / 1e6 : runtimeLenCnt / 1e3; // 使用合适的时间单位
    std::string timeUnit = runtimeLenCnt > 1e6 ? " s." : " ms.";
    std::cout << std::setprecision(3) << std::fixed
        << "\n\033[32m[END]\033[m exit with " << exitString << " in \033[36m" << timeLen << timeUnit << std::endl;

    return 0 ;
}

