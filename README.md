# My SpaceVim for VSCode User

&emsp;我的主力 IDE 已经从 SpaceVim 迁移到 VSCode 了，master 分支如无意外将停止更新，转而持续更新该 vscode 分支。
此 vscode 分支目的是为用作平时终端操作时的顺手工具，[快捷键操作](https://github.com/mrbeardad/My-IDE/blob/master/wsl.md#vim%E6%96%87%E6%9C%AC%E7%BC%96%E8%BE%91%E5%99%A8)都仿照我的 VSCode 配置。
（其中某些终端无法转换为键码序列的快捷键依赖我的[Windows Terminal 配置](https://github.com/mrbeardad/My-IDE/blob/master/WindowsTerminal/settings.json)，原理即是终端按键重映射，例如将`ctrl+shift+s`重映射成`\u001bS`序列）

&emsp;当然这套配置依旧完全可胜任 IDE 的工作（除了调试），对比 master 分支犹有过之而无不及。值得注意的是，配置中使用的补全引擎是[ycm](https://github.com/ycm-core/YouCompleteMe)而不是默认的[deoplete](https://github.com/Shougo/deoplete.nvim)，就我而言前者(ycm)的使用体验绝对是 vim 各个补全引擎中最好的，但可惜 SpaceVim 原作者对其支持远不如后者。

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

## Install

```sh
git clone -b vscode https://gitee.com/mrbeardad/SpaceVim ~/.SpaceVim
[[ -e ~/.SpaceVim.d ]] && mv ~/.SpaceVim.d{,.backup}
ln -sv ~/.SpaceVim/mode/ ~/.SpaceVim.d
[[ -e ~/.config/nvim ]] && mv ~/.config/nvim{,-bcakup}
ln -sv ~/.SpaceVim/ ~/.config/nvim/

# 进入neovim将自动安装插件
nvim
```

大部分插件都能依照上面的脚本来安装，除了：

- YCM 补全引擎插件下载后需要手动构建，进入 YCM 插件目录执行构建脚本

```sh
cd ~/.cache/vimfiles/repos/github.com/ycm-core/YouCompleteMe
# 你也可以使用--help参数查看支持的语言来选择性安装，注意该脚本需要网络下载代码
./install.py --all
```

- Leaderf 模糊搜索引擎插件下载后，可选的构建 C 扩展模块来加速搜索，构建依赖很可能不满足，需要自己手动解决，进入`nvim`后执行`:LeaderfInstallCExtension`来构建。执行任何 Leaderf 搜索命令后（例如`ctrl+p`）查看变量`:echo g:Lf_fuzzyEngine_C`，若为 1 则构建成功。至少在 ubuntu20.04 上需要额外安装`sudo apt install libpython2-dev`

## Depends

| 依赖                | 下载 | 备注                                                           |
| ------------------- | ---- | -------------------------------------------------------------- |
| neovim              | apt  | 版本 v0.6.1                                                    |
| pynvim              | pip  | 更新 neovim 的 python 接口                                     |
| ripgrep             | apt  | 搜索引擎                                                       |
| universal-ctags     | apt  | 标签栏                                                         |
| global              | apt  | 项目符号搜索，需要复制 gtags.conf 到~/.globalrc                |
| pygments            | pip  | 项目符号搜索                                                   |
| cloc                | apt  | 项目代码统计                                                   |
| vim-language-server | npm  | vim lsp                                                        |
| vint                | pip  | vim linter                                                     |
| shellcheck          | apt  | shell linter                                                   |
| shfmt               | go   | shell formatter, github.com/mvdan/sh                           |
| cppcheck            | apt  | c++ linter                                                     |
| clang-format        | apt  | c++ formatter                                                  |
| golangci-lint       | go   | go linter, github.com/golangci/golangci-lint/cmd/golangci-lint |
| frosted, pylama     | pip  | python linter                                                  |
| yapf                | pip  | python formatter                                               |
| eslint_d            | npm  | js linter                                                      |
| htmlhint            | npm  | html linter                                                    |
| csslint             | npm  | css linter                                                     |
| markdownlint        | npm  | markdown linter                                                |
| prettier            | npm  | js,html,css,markdown formatter                                 |

以上，感谢诸君的:star:，很荣幸能帮到你们！
