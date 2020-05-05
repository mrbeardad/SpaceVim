#include <iostream>
#include <iomanip>
#include <chrono>
#include <string>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <fcntl.h>

using namespace std ;

const char* Signal[31]{ " SIGHUP ", " SIGINT ", " SIGQUIT ", " SIGILL ", " SIGTRAP ", " SIGABRT ", " SIGBUS ", " SIGFPE ", " SIGKILL ", " SIGUSR1 ", " SIGSEGV ", " SIGUSR2 ", " SIGPIPE ", " SIGALRM ", " SIGTERM ", " SIGSTKFLT ", " SIGCHLD ", " SIGCONT ", " SIGSTOP ", " SIGTSTP ", " SIGTTIN ", " SIGTTOU ", " SIGURG ", " SIGXCPU ", " SIGXFSZ ", " SIGVTALRM ", " SIGPROF ", " SIGWINCH ", "SIGIO ", " SIGPWR ", " SIGSYS " } ;

int main(int argc, char *argv[])
{
    ios::sync_with_stdio(false) ;
    cin.tie(nullptr) ;

    auto runtimeBegin = chrono::steady_clock::now() ;

    if ( fork() == 0 ) {
        if ( execv( argv[1], &argv[1] ) != 1 ) {
            cout << argv[1] << '\n' ;
            cout << "\033[31mQuickrun Error: \033[33mOh~ my dear! Please give me the \033[35mcorrect\033[33m and \033[35mcomplete\033[33m execute path, OK?!\033[m" << endl ;
            exit(1) ;
        }
    }
    int status ;
    wait(&status) ;

    chrono::microseconds runtimelen = chrono::duration_cast<chrono::microseconds>(chrono::steady_clock::now() - runtimeBegin) ;

    string exitString ;
    if ( WIFEXITED(status) ) {
        if ( int exitCode = WEXITSTATUS(status); exitCode == 0 ) {
            exitString = "\033[1;32mcode=0\033[m" ;
        } else {
            exitString = "\033[1;33mcode=" + to_string(exitCode) + "\033[m" ;
        }
    } else if ( WIFSIGNALED(status) ) {
        int signalNum{ WTERMSIG(status) } ;
        exitString = "\033[1;31mSignal=" + to_string(signalNum) + Signal[signalNum - 1] + "\033[m" ;
    }

    double timeLen ;
    string timeUnit ;
    if ( runtimelen.count() > 1e6 ) {
        timeLen = runtimelen.count() / 1e6 ;
        timeUnit = " s." ;
    } else {
        timeLen = runtimelen.count() / 1e3 ;
        timeUnit = " ms." ;
    }
    cout << setprecision( 3 ) << fixed << "\n\033[32m[END]\033[m exit with " << exitString << " in \033[36m" << timeLen << timeUnit << endl ;

    return 0 ;
}

