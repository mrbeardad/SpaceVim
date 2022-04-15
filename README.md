# SpaceVim for VSCode User

&emsp;我的主力 IDE 已经从 SpaceVim 迁移到 VSCode 了，master 分支如无意外将停止更新，转而持续更新该 vscode 分支。
此 vscode 分支目的是为用作平时终端操作时的顺手工具，[快捷键操作](https://github.com/mrbeardad/My-IDE/blob/master/wsl.md#vim%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8)都仿照我的 VSCode 配置。
（其中某些终端无法转换为键码序列的快捷键依赖我的[Windows Terminal 配置](https://github.com/mrbeardad/My-IDE/blob/master/WindowsTerminal/settings.json)，原理即是终端按键重映射，例如将`ctrl+shift+s`重映射成`\u001bS`序列）

&emsp;当然这套配置依旧完全可胜任 IDE 的工作（除了调试），需要注意的是，配置中使用的补全引擎是[ycm](https://github.com/ycm-core/YouCompleteMe)而不是默认的[deoplete](https://github.com/Shougo/deoplete.nvim)，就我而言前者(ycm)的使用体验绝对是 vim 各个补全引擎中最好的，但可惜 SpaceVim 原作者对其支持远不如后者。

&emsp;为了弥补 ycm 在一些语言上的空缺，你可以自行阅读[YCM 文档](https://github.com/ycm-core/YouCompleteMe#installation)，安装对应的 language-server 即可。如何有一些官方未支持的语言，你可以自行在[lsp](https://microsoft.github.io/language-server-protocol/implementors/servers/)里搜索语言对应的 language-server，然后配置 ycm 连接到他即可。

```vim
" https://microsoft.github.io/language-server-protocol/implementors/servers/
let g:ycm_language_server =
  \ [
  \   {
  \     'name': 'vim',
  \     'cmdline': [ 'vim-language-server', '--stdio' ],
  \     'filetypes': [ 'vim' ],
  \    },
  \ ]
```

&emsp;与 master 分支不同的是，此分支对 SpaceVim 源代码修改极少（仅寥寥数行），用户配置几乎都在[mode/init.toml](mode/init.toml)和[autoload/myspacevim.vim](autoload/myspacevim.vim)中，很方便与上游同步。

以上，感谢诸君的:star:，很荣幸能帮到你们！
