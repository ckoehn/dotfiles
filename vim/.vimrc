" Plugins
call plug#begin('~/.vim/plugged')
Plug 'christoomey/vim-sort-motion'
Plug 'christoomey/vim-system-copy'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries'}
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf.vim'
Plug 'morhetz/gruvbox'
Plug 'python-mode/python-mode', { 'for': 'python' }
Plug 'scrooloose/nerdtree'
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

Plug '~/.fzf'
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

set list                        " show invisible characters
set listchars=""                " reset the listchars
set listchars+=tab:▸\           " show tabs as ▸
set listchars+=eol:¬            " show end of line as ¬
set listchars+=trail:.          " show trailing spaces as dots
set listchars+=extends:>        " show > if the text continues beyond the vim window

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
set textwidth=0                 " no automatic text wrapping

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

" close window
map <leader>q :q<CR>

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
noremap = $

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
autocmd FileType python,yaml autocmd BufWritePre <buffer> %s/\s\+$//e
autocmd FileType yaml,markdown,gitcommit setlocal spell
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
autocmd FileType go setlocal ts=4 sts=4 sw=4 noexpandtab

" ---------- PLUGINS ----------
" -----------------------------
" fzf
nnoremap <silent> <leader>ag :Ag<CR>
nnoremap <silent> <Leader>aw :Ag <C-R><C-W><CR>
nnoremap <silent> <leader>b :Buffers<CR>
nnoremap <silent> <leader>f :Files<CR>
nnoremap <silent> <leader>gc :Commits<CR>
nnoremap <silent> <leader>gs :GitFiles?<CR>
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

" airline
let g:airline_powerline_fonts = 1

" fugitive
map <leader>dg :diffget<CR>
map <leader>dp :diffput<CR>
map <leader>gb :Gblame<CR>
map <leader>gd :Gvdiff<CR>

" pymode
let g:pymode_breakpoint = 1
let g:pymode_breakpoint_bind = '<leader>rb'
let g:pymode_doc = 0
let g:pymode_lint = 1
let g:pymode_options_max_line_length = 100
let g:pymode_rope = 1
let g:pymode_rope_completion = 0
let g:pymode_rope_goto_definition_bind = '<leader>rg'
let g:pymode_rope_regenerate_on_write = 0
let g:pymode_rope_rename_bind = '<leader>rr'
let g:pymode_rope_show_doc_bind = ''
let g:pymode_run = 0

" go
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_arguments = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1
