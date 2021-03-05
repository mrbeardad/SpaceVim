# Sort `#include` statements in Vim

# Usage
This vim plugin provides only `SortInclude` command.
It sort `#include` statements in the current buffer.

If you want to execute the command every time you save the file,
write to your `.vimrc`:

```vim
augroup sort-include
  autocmd!
  autocmd BufWritePre *.{c,cpp,h,hpp} SortInclude
augroup END

```
