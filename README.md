# My SpaceVim for VSCode User

&emsp;我的主力 IDE 已经从 SpaceVim 迁移到 VSCode 了，master 分支如无意外将停止更新，转而持续更新该 vscode 分支。
此 vscode 分支目的是为用作平时终端操作时的顺手工具，[快捷键操作](#key-maps)都仿照我的 VSCode 配置。
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

- Leaderf 模糊搜索引擎插件下载后，可选的构建 C 扩展模块来加速搜索，构建依赖很可能不满足，需要自己手动解决，进入`nvim`后执行`:LeaderfInstallCExtension`来构建。执行任何 Leaderf 搜索命令后（例如`ctrl+p`）查看变量`:echo g:Lf_fuzzyEngine_C`，若为 1 则构建成功。至少在 ubuntu20.04 上需要额外安装`libpython2-dev`

**注意**：项目符号搜索需要先手动执行`:Leaderf gtags --update`构建符号数据库，以后则自动更新。或者设置`let g:Lf_GtagsAutoGenerate = 1`自动创建。

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

# Key Maps

## 光标移动

| 按键           | 作用                     |
| -------------- | ------------------------ |
| `Ctrl`+`←/→`   | 左/右移一个单词          |
| `Ctrl`+`A/E`   | 行首/行尾                |
| `f/F` `{char}` | 下/上一个 char 字符处    |
| `;` `{char}`   | 选择并跳转到 char 字符处 |
| `{num}` `j/k`  | 下/上 num 行             |
| `%`            | 跳转结对符               |
| `gg`           | 第一行                   |
| `G`            | 最后一行                 |
| `{num}` `G`    | 跳转第{num}行            |

## 屏幕滚动

| 按键         | 作用                 |
| ------------ | -------------------- |
| `Ctrl`+`D/B` | 向下/上翻页滚屏      |
| `Ctrl`+`↓/↑` | 向下/上逐行滚屏      |
| `zz`         | 移动光标行到屏幕中央 |
| `M`          | 移动光标到屏幕中央   |

## 复制粘贴

| 按键        | 作用                         |
| ----------- | ---------------------------- |
| `y`         | 复制到 0 号寄存器            |
| `Y`         | 复制光标后文本到 0 号寄存器  |
| `\y`        | 复制到系统剪切板             |
| `\Y`        | 复制标光后文本到系统剪切板   |
| `Space` `y` | 复制整个文件到系统剪切板     |
| `=` `p/P`   | 粘贴 0 号寄存器到光标后/前   |
| `=` `o/O`   | 粘贴 0 号寄存器到下/上行     |
| `\` `p/P`   | 粘贴系统剪切板到光标后/前    |
| `\` `o/O`   | 粘贴系统剪切板到下/上行      |
| `Space` `p` | 粘贴系统剪切板覆盖至当前文件 |

## 普通模式

- 复合操作符：
  > `d` `c` `y` `gu` `gU` `g~` `v`
- 光标移动：
  > `0` `^` `$` `w` `W` `b` `B` `e` `E` `ge` `gE` `(` `)` `{` `}`  
  > `gm` `f` `F`  
  > `gg` `G` `%` `H` `L` `M`
- 文本对象：
  > `w` `s` `p` `(` `{` `[` `<` `"` `'` `` ` ``  
  > `e` `l` `i` `f` `,`

| 按键                      | 作用                      |
| ------------------------- | ------------------------- |
| `~`                       | 反转字符大小写            |
| `r`                       | 替换光标下字符            |
| `x`                       | 删除字符                  |
| `s`                       | 删除字符并进入 insert     |
| `R`                       | 从光标位置开始替换        |
| `D`                       | 删除直到行尾              |
| `C`                       | 删除直到行尾并进入 insert |
| `dd`                      | 删除当前行                |
| `cc`                      | 删除当前行并进入 insert   |
| `ys` `{textobj}` `{char}` | 添加包围符                |
| `ds` `{char}` `{char}`    | 删除包围符                |
| `cs` `{char}` `{char}`    | 替换包围符                |
| `.`                       | 重复上次操作              |

## 快速编辑

| 按键           | 作用                                    |
| -------------- | --------------------------------------- |
| `Shift`+`←`    | 左移本行                                |
| `Shift`+`→`    | 右移本行                                |
| `Shift`+`↓`    | 下移本行                                |
| `Shift`+`↑`    | 上移本行                                |
| `Ctrl`+`Enter` | 下行插入                                |
| `Ctrl`+`W`     | 删除光标前单词                          |
| `Ctrl`+`U`     | 删除光标前文本                          |
| `Ctrl`+`K`     | 删除光标后文本                          |
| `Ctrl`+`L`     | 删除光标后单词                          |
| `Ctrl`+`Z`     | 撤销                                    |
| `Ctrl`+`R`     | 重做                                    |
| `Ctrl`+`\`     | 手动触发补全列表                        |
| `Tab`          | 下个补全项                              |
| `Shift`+`Tab`  | 上个补全项                              |
| `Enter`        | 选中补全项                              |
| `Alt`+`\`      | 手动搜索 snippet                        |
| `Tab`          | 根据 snippet 前缀补全代码片段或下个锚点 |
| `Shift`+`Tab`  | 上个代码片段锚点                        |
| `Ctrl`+`/`     | 注释代码                                |
| `F2`           | 重构变量名                              |
| `Space s e`    | 多光标编辑（全选）                      |
| `Space s E`    | 多光标编辑（单选）                      |

## 搜索导航

| 按键               | 作用                 |
| ------------------ | -------------------- |
| `Ctrl`+`F`         | 搜索目录所有文件内容 |
| `Ctrl`+`H`         | 替換目录所有文件內容 |
| `Ctrl`+`P`         | 搜索文件             |
| `Ctrl`+`Shift`+`P` | 搜索命令             |
| `Ctrl`+`Shift`+`O` | 搜索本地标签         |
| `Ctrl`+`T`         | 搜索全局标签         |
| `F12`              | 跳转定义或声明       |
| `Shift`+`F12`      | 跳转引用             |
| `Ctrl`+`O`         | 后向跳转             |
| `Ctrl`+`I`         | 前向跳转             |

## 书签标记

| 按键          | 作用                   |
| ------------- | ---------------------- |
| `mm`          | 切换标签状态           |
| `mi`          | 为标签添加注释         |
| `mn`          | 跳转至下一个标签       |
| `mb`          | 跳转至上一个标签       |
| `ml`          | 列出当前文件的标签     |
| `mL`          | 列出所有标签           |
| `mc`          | 删除当前文件的标签     |
| `mC`          | 删除所有标签           |
| `m` `{alpha}` | vim 标签，大写字母全局 |
| `'` `{alpha}` | 跳转 vim 标签          |

## Buffer 操作

| 按键               | 作用                   |
| ------------------ | ---------------------- |
| `Space` `Tab`      | 快速切换               |
| `\` `n`            | 下个 buffer            |
| `\` `b`            | 上个 buffer            |
| `\` `num`          | 切换到第 num 个 buffer |
| `Ctrl`+`K` `n`     | 新建文件               |
| `Ctrl`+`K` `o`     | 打开文件               |
| `Ctrl`+`K` `r`     | 打开最近访问文件       |
| `Ctrl`+`S`         | 保存                   |
| `Alt`+`S`          | Sudo 权限保存          |
| `Ctrl`+`Shift`+`S` | 另存为                 |
| `Ctrl`+`K` `s`     | 保存所有               |
| `Ctrl`+`W` `w`     | 关闭当前文件           |
| `Ctrl`+`K` `u`     | 关闭已保存文件         |
| `Ctrl`+`K` `w`     | 关闭其他文件           |

## Window 操作

| 按键                         | 作用                                 |
| ---------------------------- | ------------------------------------ |
| `Tab`/`Shift`+`Tab`          | 跳转下/上个 Window                   |
| `Space`+`1~8`                | 跳转指定第 1~8 个 Window             |
| `Ctrl`+`W` `↑/↓/←/→`         | 跳转上/下/左/右方的 Window           |
| `Ctrl`+`W` `Shift`+`H/J/K/L` | 与/左/下/上/右方 Window 上移交换位置 |
| `Ctrl`+`W` `=`               | 均布 Window 窗口大小                 |
| `Ctrl`+`W` `v`               | 竖直切分                             |
| `Ctrl`+`W` `s`               | 水平切分                             |
| `Ctrl`+`W` `o`               | 仅保留当前 Window                    |
| `q`                          | 只能关闭 Window 或退出 vim           |
| `Ctrl`+`W` `Z`               | 暂停 vim                             |

## 界面元素

| 按键          | 作用               |
| ------------- | ------------------ |
| `F1`          | 开关文件树与标签栏 |
| `F7`          | 开关 Undo          |
| `Alt`+`` ` `` | Terminal 窗口      |

## 其他按键

| 按键              | 作用                               |
| ----------------- | ---------------------------------- |
| `:s/pat/rep/g`    | 替换命令                           |
| `g&`              | 当前行重复上次替换命令             |
| `Q` `Reg`         | 宏录制                             |
| `@` `Reg`         | 应用宏                             |
| `@@`              | 应用上次宏                         |
| `ga`              | 查看 ascii 字符编码或 unicode 码点 |
| `g8`              | 查看 utf-8 字符编码                |
| `K`               | 查看帮助文档                       |
| `Ctrl`+`G`        | 显示文件路径                       |
| `Alt`+`Z`         | 是否长行回绕                       |
| `Alt`+`Shift`+`E` | 在 Explorer 中打开文件目录         |
| `Alt`+`Shift`+`R` | 快速运行单个代码文件               |
| `Alt`+`T`         | 翻译（窗口显示）                   |
| `Alt`+`Shift`+`T` | 翻译（命令行显示）                 |
| `Alt`+`Shift`+`F` | 格式化文本                         |
| `Alt`+`Shift`+`C` | 计算器                             |
| `:CodeCounter`    | 项目代码统计                       |

# The END

以上，感谢诸君的:star:，很荣幸能帮到你们！
