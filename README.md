# SpaceVim for VSCode User
&emsp;我的主力IDE已经从SpaceVim迁移到VSCode了，master分支如无意外将停止更新，转而持续更新该vscode分支。
此vscode分支目的是为用作平时终端操作时的顺手工具，[快捷键操作](https://github.com/mrbeardad/My-IDE/blob/master/wsl.md#vim%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8)都仿照我的VSCode配置。
（其中某些终端无法转换为键码序列的快捷键依赖我的[Windows Terminal配置](https://github.com/mrbeardad/My-IDE/blob/master/WindowsTerminal/settings.json)，原理即是终端按键重映射，例如将`ctrl+shift+s`重映射成`\u001bS`序列）

&emsp;当然这套配置依旧完全可胜任IDE的工作（除了调试），需要注意的是，配置中使用的补全引擎是[ycm](https://github.com/ycm-core/YouCompleteMe)而不是默认的[deoplete](https://github.com/Shougo/deoplete.nvim)，就我而言前者(ycm)的使用体验绝对是vim各个补全引擎中最好的，但可惜SpaceVim原作者对其支持远不如后者。

&emsp;为了弥补ycm在一些语言上的空缺，你可以自行阅读[YCM文档](https://github.com/ycm-core/YouCompleteMe#installation)，安装对应的language-server即可。如何有一些官方未支持的语言，你可以自行在[lsp](https://microsoft.github.io/language-server-protocol/implementors/servers/)里搜索语言对应的language-server，然后配置ycm连接到他即可。

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

&emsp;与master分支不同的是，此分支对SpaceVim源代码修改极少（仅寥寥数行），用户配置几乎都在[mode/init.toml](mode/init.toml)和[autoload/myspacevim.vim](autoload/myspacevim.vim)中，很方便与上游同步。

以上，感谢诸君的:star:，很荣幸能帮到你们！
