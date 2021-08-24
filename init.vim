
" set powershell as default shell if using windows
set shell=powershell shellquote=( shellpipe=\| shellredir=> shellxquote=
" set shellcmdflag=-NoLogo\ -NoProfile\ -ExecutionPolicy\ RemoteSigned\ -Command

call plug#begin('~/.vim/plugged')
Plug 'chauncey-garrett/vim-tasklist'
Plug 'fholgado/minibufexpl.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
""Plug 'ervandew/supertab'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdcommenter'
" Track the engine.
Plug 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-startify'
Plug 'psliwka/vim-smoothie'

Plug 'junegunn/limelight.vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'Yggdroot/indentLine'

" much of plugins from 
" https://dev.to/christalib/i-spent-3-years-configuring-n-vim-and-this-what-i-learnt-22on

call plug#end()

"" Start deoplete
let g:deoplete#enable_at_startup = 1
"" Add Latex integration with vim
let g:python3_host_prog = 'C:\ProgramData\Anaconda3\python.exe'
call deoplete#custom#var('omni', 'input_patterns', {
      \ 'tex': g:vimtex#re#deoplete
      \})

" set first of menu selected in deoplete
 set completeopt=menu,noinsert

" setings for ultiSnips
let g:UltiSnipsExpandTrigger='<tab>'

" If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"

" shortcut to go to next position
let g:UltiSnipsJumpForwardTrigger='<c-j>'
" shortcut to go to previous position
let g:UltiSnipsJumpBackwardTrigger='<c-k>'

" " airline settings
let g:airline_theme = 'molokai'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 1

" include line number by default
set number relativenumber

" set hotkey for task list (searches for TODO comments in files)
map <leader>t <Plug>TaskList
let  g:tlTokenList = ['FIXME', 'TODO', 'XXX']

" Create default mappings
let g:NERDCreateDefaultMappings = 1

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code
let g:NERDDefaultAlign = 'left'

" Add Mouse controls
set mouse=a

" Tab behavior
set autoindent          "Automatically place indents on newlines.
set tabstop=4           "Width of a tab
set shiftwidth=2        "Indentation width (using '>' and '<'
set expandtab           "Replace tabs with spaces
set softtabstop=2       "Bacspace through expanded tabs

" set colorcolumn=80

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
" let g:limelight_bop = '^\s'
" let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1

" Stop concealing formatting when using indentLine
let g:indentLine_setConceal = 0

" Set Paste mode as default
set paste

let g:startify_session_dir = '~/.config/nvim/session'
" Get rid of empty buffers
let g:startify_enable_special = 0
let g:startify_session_before_save = [
  \ 'echo "Cleaning up before saving ..."',
  \ 'silent! NERDTreeClose'
  \ ]
