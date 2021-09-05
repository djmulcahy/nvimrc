" set powershell as default shell if using windows
if has('win32')
   let &shell = 'pwsh'
   let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned '
       \ . '-Command [Console]::InputEncoding=[Console]::'
       \ . 'OutputEncoding=[System.Text.Encoding]::UTF8;'
   let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
   let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
   set shellquote= shellxquote=
endif

" Determine which plugin used for autocomplete and snippets
" Options: [`coq`, `coc`]
let g:complete_plugin = 'coq'


" Add plugins
call plug#begin('~/.vim/plugged')

" Plugin: General for easier editing
Plug 'chauncey-garrett/vim-tasklist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'scrooloose/nerdcommenter'

" Plugin: Visuals of editor
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fholgado/minibufexpl.vim'
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'junegunn/limelight.vim'
Plug 'mhinz/vim-startify'
" Smoother scrolling
Plug 'psliwka/vim-smoothie'

" Plugin: Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


" Plugin: LSP
Plug 'neovim/nvim-lspconfig'

" Filetype: tex
Plug 'lervag/vimtex'

" Filetype: python
Plug 'psf/black', { 'branch': 'stable' }
Plug 'Vimjas/vim-python-pep8-indent'

" Filetype: Markdown
Plug 'iamcco/markdown-preview.nvim', 
		\ {'do': { -> mkdp#util#install() },
		\  'for': ['markdown', 'vim-plug']}

" Plugin: Code context and snippets
if complete_plugin == 'coc'
  Plug 'SirVer/ultisnips'
  " Snippets are separated from the engine. Add this if you want them:
  Plug 'honza/vim-snippets'
elseif complete_plugin == 'coq'
  Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
  Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
endif

Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'

call plug#end()

" Set leader to comma
let mapleader = ","

" Add Latex integration with vim
let g:python3_host_prog = 'C:\ProgramData\Anaconda3\envs\neovim'

" " setings for ultiSnips
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsListSnippets="<c-l>"
" " If you want :UltiSnipsEdit to split your window.
" " let g:UltiSnipsEditSplit="vertical"

" " shortcut to go to next position
" let g:UltiSnipsJumpForwardTrigger="<c-j>"
" " shortcut to go to previous position
" let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"set to 0 if you want to enable it later via :RainbowToggle 
let g:rainbow_active = 1 

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

"TODO: Make overrides for specific files like python
" Tab behavior
set autoindent          "Automatically place indents on newlines.
set tabstop=4           "Width of a tab
set shiftwidth=2        "Indentation width (using '>' and '<'
set softtabstop=2       "Bacspace through expanded tabsset colorcolumn=80
set softtabstop=2       "Bacspace through expanded tabs

set colorcolumn=80

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

" Set noPaste mode as default
" paste stops autocomplete functionality
set nopaste

let g:startify_session_dir = '~/.config/nvim/session'
" Get rid of empty buffers
let g:startify_enable_special = 0
let g:startify_session_before_save = [
  \ 'echo "Cleaning up before saving ..."',
  \ 'set g:startify_session_with_NERDTree = 0',
  \ 'if exists("g:NERDTree") && g:NERDTree.IsOpen()',
  \ '    set g:startify_session_with_NERDTree = 1',
  \ '    silent! NERDTreeClose',
  \ 'endif'
  \ ]

" Add commands that mimic fugitive plugin to push and fetch git repos
command! -bang -bar -nargs=* Gpush execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git push' <q-args>
command! -bang -bar -nargs=* Gfetch execute 'Dispatch<bang> -dir=' .
      \ fnameescape(FugitiveGitDir()) 'git fetch' <q-args>

" Add add mapping for controling tabs in vim
map <leader>tn :tabnew<cr>
map <leader>t<leader> :tabnext
map <leader>tm :tabmove
map <leader>tc :tabclose<cr>
map <leader>to :tabonly<cr>

" Use numpy style for python comments by default
let g:ultisnips_python_style="numpy"
if complete_plugin == 
" Config for LSP and COQ
lua << EOF
local lsp = require'lspconfig'
local coq = require'coq'

lsp.jedi_language_server.setup{}
lsp.jedi_language_server.setup{ coq.lsp_ensure_capabilities() } 
EOF
