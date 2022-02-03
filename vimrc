" plugin list
call plug#begin('~/.vim/plugged')
" themes
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'         
Plug 'altercation/vim-colors-solarized'

Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Insert与Normal模式下，自动切换输入法 
Plug 'lyokha/vim-xkbswitch',{'as':'kbswitch'}        
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-unimpaired'
Plug 'mg979/vim-visual-multi'

call plug#end()


" leader
let mapleader = ','
let g:mapleader = ','

" setting for netrw plugin
let g:netrw_altv = 1                 " 控制 v 分裂的窗口位于右边
let g:netrw_alto = 0                 " 控制预览窗口位于左侧或右侧, 与 netrw_preview 共同作用
let g:netrw_preview = 1              " 默认是水平分割, 此项设置使之垂直分割
let g:netrw_winsize = 30             " 占用宽度
let g:netrw_liststyle = 3            " tree 模式显示风格
let g:netrw_localrmdir = 'trash'     " 默认的删除工具使用 trash

" setting for autoswitch-inputmehtod. see: https://github.com/lyokha/vim-xkbswitch
let g:XkbSwitchEnabled = 1
" https://github.com/vovkasm/input-source-switcher
let g:XkbSwitchLib = '/usr/local/lib/libInputSourceSwitcher.dylib'
let g:XkbSwitchKeymapNames = {'us' : 'com.apple.keylayout.ABC', 'rime' : 'im.rime.inputmethod.Squirrel.Rime'}
let g:XkbSwitchNLayout = 'us'
let g:XkbSwitchIMappings = ['Rime']                         " 可通过xkbswitch -ge获取layout名称
let g:XkbSwitchIMappingsTr = {'Rime': {'<': '', '>': ''}}   " 需要与IMappings配合设置,否则报错

" syntax
syntax on

" history : how many lines of history VIM has to remember
set history=2000

" use the system clipboard
set clipboard^=unnamed,unnamedplus

" filetype
filetype on

" Enable filetype plugins
filetype plugin on
filetype indent on


" base
set nocompatible                " don't bother with vi compatibility
set autoread                    " reload files when changed on disk, i.e. via `git checkout`
set shortmess=atI

set magic                       " For regular expressions turn magic on
set title                       " change the terminal's title
set nobackup                    " do not keep a backup file

set novisualbell                " turn off visual bell
set noerrorbells                " don't beep
set visualbell t_vb=            " turn off error beep/flash
set t_vb=
set tm=500


" show location
set cursorcolumn
set cursorline


" movement
set scrolloff=7                 " keep 7 lines when scrolling


" show
set ruler                       " show the current row and column
set number                      " show line numbers
set nowrap
set showcmd                     " display incomplete commands
set showmode                    " display current modes
set showmatch                   " jump to matches when entering parentheses
set matchtime=2                 " tenths of a second to show the matching parenthesis


" search
set hlsearch                    " highlight searches
set incsearch                   " do incremental searching, search as you type
set ignorecase                  " ignore case when searching
set smartcase                   " no ignorecase if Uppercase char present


" tab
set expandtab                   " expand tabs to spaces
set smarttab
set shiftround

" indent
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4                " insert mode tab and backspace use 4 spaces

" NOT SUPPORT
" fold
set foldenable
set foldmethod=indent
set foldlevel=99

" fzf key complete
set rtp+=/opt/homebrew/opt/fzf

let g:FoldMethod = 0
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" encoding
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B

" select & complete
set selection=inclusive
set selectmode=mouse,key

set completeopt=longest,menu
set wildmenu                           " show a navigable menu for tab completion"
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class

" others
set backspace=indent,eol,start  " make that backspace key work the way it should
set whichwrap+=<,>,h,l

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" after modify auto reload the .vimrc
autocmd! BufWritePost .vimrc source %


" ============================ theme and status line ============================
set background=dark

" setting different theme for mac_vim
if has("gui_running")
    colorscheme  onedark
else   
    colorscheme  solarized
endif


" set fontsiz for macvim
if has("gui_running")
    set guifont=Monaco:h14
endif


" set mark column color
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" status line
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2   " Always show the status line


" ============================ specific file type ===========================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd BufRead,BufNew *.md,*.mkd,*.markdown  set filetype=markdown.mkd

autocmd BufNewFile *.sh,*.py exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    " .sh
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    " python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    normal G
    normal o
    normal o
endfunc

autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()
function! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun



" ============================ key map ============================

" select all
map <Leader>sa ggVG"

" y$ -> Y Make Y behave like other capitals
map Y y$

"  
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l


" kj 替换 Esc
inoremap kj <Esc>


" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

nnoremap ; :

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j


" Shift+H goto head of the line, Shift+L goto end of the line
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $


" remap U to <C-r> for easier redo
nnoremap U <C-r>

nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>


" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>


"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent.调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv


" save
cmap w!! w !sudo tee >/dev/null %

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
