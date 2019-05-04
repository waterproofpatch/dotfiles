filetype off
call pathogen#infect()
call pathogen#helptags()

set t_Co=256
let g:solarized_termcolors=256
colorscheme solarized
set background=dark

syntax enable
set tabstop=4 " number of visual spaces per tab
set ignorecase
set noswapfile " no swap file
set smartcase " case sensitive only when capital letters used
setl rnu " relative line number
set softtabstop=4 " number of space in tab when editing
set expandtab " tabs are spaces
set number " show line number
set showcmd " show command in bottom bar
set cursorline " highlight current line
filetype indent on " load filetype specific indend tiles
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only as necessary
set showmatch " hilight matching [{()}]
set incsearch " match as chars entere
set encoding=utf-8
set hlsearch
set laststatus=2
nnoremap gV `[v`]
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
:let mapleader = ','
:imap jk <Esc>

"python mode
let g:pymode_python = 'python3'

" Put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir

" Keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

"toggle relative line numbers
nn <silent> <leader>l :call ToggleNumber()<CR>
fun! ToggleNumber() "{{{
    if exists('+relativenumber')
        :exec &nu==&rnu? "setl nu!" : "setl rnu!"
    else
        setl nu! 
    endif
endf "}}}

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

"buffer navigations
nnoremap <C-n> :bnext<cr>
nnoremap <C-b> :bprev<cr>


"clang format stuff
"format on buffer write
"let g:clang_format#auto_format=1
autocmd FileType c ClangFormatAutoEnable
map <C-F> :ClangFormat<cr>
imap <C-F> <c-o>:ClangFormat<cr>
autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=8 shiftwidth=2 softtabstop=2
autocmd FileType python set expandtab shiftwidth=4 softtabstop=0
autocmd FileType asm set expandtab shiftwidth=8 softtabstop=0 syntax=nasm
autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
autocmd FileType vue,html,xhtml,css,xml,xslt set shiftwidth=2 softtabstop=2


au! BufRead,BufNewFile *.json set filetype=json
augroup json_autocmd
  autocmd!
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set conceallevel=0
augroup END

