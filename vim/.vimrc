" Plugins
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'itchyny/lightline.vim'
" Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
call plug#end()

" General options
set cursorline                  " show cursor
set encoding=utf-8              " proper encoding
set hidden                      " allow background buffers
set history=1000
set nocompatible                " no compatibility with legacy vi
set number                      " show line numbers
set showcmd                     " display incomplete commands in statusline
set visualbell                  " don't beep
set t_vb=                       " don't flash screen

syntax on

" Backup
set nobackup
set noswapfile
set nowb

if exists("+undofile")
	set undofile                  " keep undo information
	set undodir=~/.vim/history//  " where to put the undo files. // -> filename will be built from complete path
endif

set lazyredraw                  " Don't update while in macro
set ttyfast                     " Improves redrawing

set list                        " Show whitespace as special chars - see listchars
set listchars=tab:▸\ ,extends:›,precedes:‹,nbsp:·,trail:·
set fillchars+=vert:│           " pretty vertical splits

" Folds
set foldmethod=indent
set foldnestmax=3
set nofoldenable

" Scrolling
set scrolloff=5                 " show 5 more lines when scrolling
set sidescrolloff=15
set sidescroll=1

" Tabs, spaces, wrapping
filetype plugin indent on
set nowrap                      " don't wrap lines
set textwidth=100

" Searching
set hlsearch                    " highlight matches
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter

" Appearance
if has("termguicolors")
	set termguicolors
else
	set t_Co=256
endif

" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''

set background=dark
let g:gruvbox_contrast_dark='hard'
silent! colorscheme gruvbox

" 'warning' marker
highlight ColorColumn ctermbg=236 guibg=#3c3836
let &colorcolumn=100

" -------- KEY MAPPING --------
" -----------------------------
" Leader
let mapleader = ","

" remove search highlighting
map <leader><space> :noh<cr>

" previous/next search occurence
nnoremap n nzz
nnoremap N Nzz

" search for matching brackets
nnoremap <tab> %
vnoremap <tab> %

" Split window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" new vertical/horizontal split
nnoremap vv <C-w>v<C-w>l
nnoremap ss <C-w>s<C-w>j

" equal height/width of splits
nnoremap <leader>0 <C-w>=

" popupmenu keys
inoremap <expr> <C-j> pumvisible() ? "\<C-N>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-P>" : "\<C-k>"

" Edit vim configuration
nnoremap <leader>ev <C-w>s<C-w>j<C-w>L:e ~/.vimrc<cr>

map <leader>q :q<CR>
map <leader>w :w<CR>

" make < > keep selection
vnoremap < <gv
vnoremap > >gv

set pastetoggle=<F2>

" switch between current and last buffer
nnoremap <leader><leader> <c-^>

" map esc in insert mode
inoremap jj <Esc>

" surround
map <leader>" ysiw"
map <leader>' ysiw'
map <leader>) ysiw)
map <leader>] ysiw]
map <leader>} ysiw}

" Start/End of line
noremap 0 ^
noremap ^ 0
noremap ) $

" reload
nmap <silent> ,vr :so %<CR>

" spell
nnoremap sn ]s
nnoremap sN [s
nnoremap sf :call FzfSpell()<CR>
nnoremap <leader>sf 1z=
nnoremap <leader>sa zg

function! FzfSpellSink(word)
  exe 'normal! "_ciw'.a:word
endfunction

function! FzfSpell()
  let suggestions = spellsuggest(expand("<cword>"), 10)
  return fzf#run({'source': suggestions, 'sink': function("FzfSpellSink"), 'down': 10 })
endfunction

" ---------- FILES -----------
" -----------------------------
augroup filetypes
	au!
	au FileType yaml autocmd BufWritePre <buffer> %s/\s\+$//e
	au FileType yaml,markdown,gitcommit setlocal spell
	au FileType proto,sh,vim,yaml,zsh setlocal ts=2 sts=2 sw=2 expandtab
	au FileType c,typescript setlocal ts=4 sts=4 sw=4 expandtab
augroup end

" ---------- PLUGINS ----------
" -----------------------------
" fzf
nnoremap <silent> <leader>ag :Ag<CR>
nnoremap <silent> <Leader>aw :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>gh :BCommits<CR>
let g:fzf_preview_window = ''
let g:fzf_commits_log_options = '--format="%C(yellow)%h %ad%Cred%d %Creset%s%Cblue [%aN]" --color=always --decorate --date=short'
let g:fzf_buffers_jump = 1
let g:fzf_layout = { 'down': '~20%' }
" https://github.com/gruvbox-community/gruvbox/blob/ecba37e6b34410d27074247696a0c9fcc8558f7e/colors/gruvbox.vim#L897
let g:fzf_colors = {
\ 'fg':      ['fg', 'GruvboxFg1'],
\ 'bg':      ['fg', 'GruvboxBg0'],
\ 'hl':      ['fg', 'GruvboxYellow'],
\ 'fg+':     ['fg', 'GruvboxFg1'],
\ 'bg+':     ['fg', 'GruvboxBg1'],
\ 'hl+':     ['fg', 'GruvboxYellow'],
\ 'info':    ['fg', 'GruvboxBlue'],
\ 'prompt':  ['fg', 'GruvboxFg4'],
\ 'pointer': ['fg', 'GruvboxBlue'],
\ 'marker':  ['fg', 'GruvboxOrange'],
\ 'spinner': ['fg', 'GruvboxYellow'],
\ 'header':  ['fg', 'GruvboxBg3']
\ }

" nerdtree
map <silent> <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$']

" lightline
set laststatus=2
set noshowmode

let g:lightline = {
  \ 'colorscheme': 'gruvbox',
  \ 'active': {
  \   'left': [[], ['paste', 'spell'], ['filename']],
  \   'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding', 'filetype']]
  \ },
  \ 'component_function': {
  \   'branch': 'fugitive#head',
  \   'fileencoding': 'LightlineFileencoding',
  \   'fileformat': 'LightlineFileformat',
  \   'filename': 'LightlineFilename',
  \   'filetype': 'LightlineFiletype'
  \ },
  \ }

function! LightlineReadonly()
  return &ft !~? 'help\|fugitive\|git' && &readonly ? '🔒' : ''
endfunction

function! LightlineModified()
  return &ft =~ 'help\|fugitive\|git' ? '' : &modified ? '[+]' : &modifiable ? '' : '[-]'
endfunction

function! LightlineFilename()
  return  ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != expand('%') ? expand('%') : '[No Name]') .
        \ ('' != LightlineModified() ? LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : '-') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

" fugitive
noremap <silent> <leader>dg :diffget<CR>
noremap <silent> <leader>dp :diffput<CR>
nnoremap <silent> <leader>gb :Git blame<CR>
nnoremap <silent> <leader>gd :Gvdiff<CR>
nnoremap <silent> <leader>gs :Git<CR>

" go
augroup filetype_go
	au!
	au FileType go setlocal ts=4 sts=4 sw=4 noexpandtab
	au Filetype go nmap <leader>ga :GoAlternate<CR>
	au Filetype go nmap <leader>gct :GoCoverageToggle<CR>
aug end

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

let g:go_fmt_options = {
\ 'goimports': '-local gitlab.figo.systems',
\ }

" ultisnips
let g:UltiSnipsExpandTrigger="<c-u>"

" coc
let g:coc_global_extensions = ["coc-python", "coc-json", "coc-yaml"]

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ge :CocList diagnostics<CR>
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gr <Plug>(coc-references)

" python
let g:python_breakpoint_cmd = "breakpoint()"

fun! PythonBreakpoint(lnum)
  let plnum = prevnonblank(a:lnum)
  if &expandtab
    let indents = repeat(' ', indent(plnum))
  else
    let indents = repeat("\t", plnum / &shiftwidth)
  endif

  call append(line('.')-1, indents.g:python_breakpoint_cmd)
  normal k
endfun

augroup filetype_python
  au!
  nnoremap <leader>rb :call PythonBreakpoint(line('.'))<CR>
augroup end
