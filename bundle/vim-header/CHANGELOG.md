# Change Log
All notable changes to this project will be documented in this file.
This project adheres to [Semantic Versioning](http://semver.org/).

## [Unreleased]
### Added
- This CHANGELOG file
- Filetype support for grovy, haskel, lua, sass, html, tmux, go, scala, ruby, elixir, erlang, plaintex, lisp, scheme, asm, clojure, cs, xdefaults, ocaml, pug, rust, matlab/octave, cfg, yaml, verilog, vhdl, rst, tex, arduino, perl6, vimwiki, make, kotlin, react (jsx and tsx)
- Control for auto space after comment char according to language.
- Specific field placeholders according to file type
- Auto add header support
- Modified date field
- Modified date by field
- License field
- New algorithm for updating headers allowing them to be updated within a range (g:header_max_size global option)
- Align headers values to longer header name(g:header_alignment)
- Python path now points to python3
- File name without relative path mode
- Custom copyright line

### Fixed
- Make plugin determine file type for each call to catch new file type if changed

## 0.1.0 - 2016-03-13
### Added
- Filetype support for c, cpp, css, java, javascript, php, perl, python, sh, vim
- Brief author info header
- License header

[Unreleased]: https://github.com/alpertuna/vim-header/compare/v0.1.0...HEAD
