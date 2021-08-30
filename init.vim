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

" Add plugins
call plug#begin('~/.vim/plugged')
Plug 'chauncey-garrett/vim-tasklist'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'

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

" Plugin: Code context and snippets
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lervag/vimtex'
Plug 'scrooloose/nerdcommenter'

" Filetype: python
Plug 'psf/black', { 'branch': 'stable' }
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'pappasam/coc-jedi', 
	\ { 'do': 'yarn install --frozen-lockfile && yarn build',
	\ 'branch': 'main' 
	\ }
" Filetype: Markdown
Plug 'iamcco/markdown-preview.nvim', 
		\ {'do': { -> mkdp#util#install() },
		\  'for': ['markdown', 'vim-plug']}

" Plugin: Snippets
" Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

Plug 'luochen1990/rainbow'
Plug 'Yggdroot/indentLine'

call plug#end()

" Set leader to comma
let mapleader = ","

" Add Latex integration with vim
let g:python3_host_prog = 'C:\ProgramData\Anaconda3\python.exe'

let g:coc_global_extensions = [
\  'coc-emoji', 'coc-eslint', 'coc-prettier',
\  'coc-tsserver', 'coc-tslint', 'coc-tslint-plugin',
\  'coc-css', 'coc-json', 'coc-yaml', 'coc-vimtex',	
\  'coc-jedi', 'coc-snippets']

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


let g:ultisnips_python_style="NUMPY"

"""" Settings for coc """
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=yes
else
"  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
