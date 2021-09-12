# Vimrc
This is my vimrc file (`init.vim`) including plugins used primarily with neovim.

## Requirements

* [`node>=12` for `coc.nvim` and `coc-jedi`](https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim)
* `python3` with vim package (path set in `init.vim`)

* Python requirements can be found in `environment.yml` to create conda env. However, `g:python_host_path` must be updated in `.init.vim`

## Vim Setup

[vim-plug](https://github.com/junegunn/vim-plug) is used as plugin manager.

To use this file, some additional setup might be required to connect python for some plugins.

## Resources that I used

* https://dev.to/christalib/i-spent-3-years-configuring-n-vim-and-this-what-i-learnt-22on

##TODO

- [ ] Add more langauage servers
