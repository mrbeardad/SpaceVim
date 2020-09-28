#include <chrono>
#include <fcntl.h>
#include <iomanip>
#include <iostream>
#include <string>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>

namespace
{
    const char* Signal[31]{
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
        "SIGIO ",
        "SIGPWR",
        "SIGSYS"
    };

    void fork_and_execv(const char* cmd, char* const argv[], int* stat)
    {
        if ( fork() == 0 ) {
            if ( execvp(cmd, argv) != 1 ) {
                std::cout << argv[0];
                std::cout << "\n\033[31mQuickrun Error: \033[33mOh~ my dear! Something goes wrong with \033[35mexecp()\033[m" << std::endl;
                exit(EXIT_FAILURE);
            }
        }
        wait(stat);
    }
}

int main(int argc, char* argv[])
{
    std::ios::sync_with_stdio(false);
    std::cin.tie(nullptr);

    // 执行子进程并计时
    auto runtimeBegin = std::chrono::steady_clock::now();
    int stat{};
    fork_and_execv(argv[1], argv + 1, &stat);
    auto runtimeLen = std::chrono::duration_cast<std::chrono::microseconds>(std::chrono::steady_clock::now() - runtimeBegin);

    std::string exitString{};
    if ( WIFEXITED(stat) ) { // 子进程是否未被强制停止
        if ( auto exitCode = WEXITSTATUS(stat); exitCode == 0 ) {
            exitString = "\033[1;32mcode=0\033[m";
        } else {
            exitString = "\033[1;33mcode=" + std::to_string(exitCode) + "\033[m";
        }
    } else if ( WIFSIGNALED(stat) ) { // 子进程因接收到信号而被强制停止
        int signalNum{ WTERMSIG(stat) };
        exitString = "\033[1;31mSignal=" + std::to_string(signalNum) + ' ' + Signal[signalNum - 1] + ' ' + "\033[m";
    }

    auto runtimeLenCnt = runtimeLen.count();
    auto timeLen = runtimeLenCnt > 1e6 ? runtimeLenCnt / 1e6 : runtimeLenCnt / 1e3;
    std::string timeUnit = runtimeLenCnt > 1e6 ? " s." : " ms.";
    std::cout << std::setprecision(3) << std::fixed << "\n\033[32m[END]\033[m exit with " << exitString << " in \033[36m" << timeLen << timeUnit << std::endl;

    return 0 ;
}

