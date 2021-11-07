filetype off

" vim-plug
call plug#begin()
" comment a plugin to disable it on startup
Plug 'itchyny/lightline.vim' " status line
Plug 'mengelbrecht/lightline-bufferline' " display buffers at top
Plug 'dense-analysis/ale' " async linting
Plug 'morhetz/gruvbox' " colorscheme
Plug 'ludovicchabant/vim-gutentags' " auto tag maintenance
Plug 'xolox/vim-misc' " dependency for something
Plug 'rhysd/vim-clang-format' " :ClangFormat
Plug 'easymotion/vim-easymotion' " numbered motions
Plug 'christoomey/vim-tmux-navigator' " for tmux
Plug 'tpope/vim-fugitive' " git integration
Plug 'tpope/vim-commentary' " comments 'gcc'
Plug 'tpope/vim-surround' " quotes and things
Plug 'tpope/vim-vinegar' " nicer handling of netrw
" Plug 'vim-scripts/AutoComplPop' " Auto open complete menus
Plug 'leafoftree/vim-vue-plugin' " vue syntax and linting
Plug 'joe-skb7/cscope-maps' " cs stuff
Plug 'NLKNguyen/c-syntax.vim' " better syntax highlighting
Plug 'majutsushi/tagbar' " :TagBar
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fzf
Plug 'junegunn/fzf.vim' " fzf bindings
Plug 'liuchengxu/vim-clap' " experimental TODO do I want this?
Plug 'airblade/vim-gitgutter' " gitgitter

" Language plugins
Plug 'rust-lang/rust.vim' " rust syntax etc.
Plug 'tell-k/vim-autopep8' " auto format python code

call plug#end()

filetype indent on " load filetype specific indent tiles
" set omnifunc=syntaxcomplete#Complete
set completeopt=menuone,menu,longest,preview

syntax enable
colorscheme gruvbox
set background=dark

" settings
set relativenumber " relno
" set clipboard=unnamedplus " use system clipboard 
set completeopt+=menuone " add mucomplete to autocompleters
set tabstop=4 " number of visual spaces per tab
set ignorecase " ignore case by default while searching
set noswapfile " no swap file
set smartcase " case sensitive only when capital letters used
setl rnu " relative line number
set scrolloff=5 " see lines below cursor
set autoread " reload files on buffer enter, etc.
set softtabstop=4 " number of space in tab when editing
set expandtab " tabs are spaces
set number " show line number
set showcmd " show command in bottom bar
set cursorline " highlight current line
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only as necessary
set showmatch " hilight matching [{()}]
set incsearch " match as chars entere
set encoding=utf-8 " default encoding for new files
set hlsearch " hilight search as matches are found while typing
set laststatus=2 " start in display-status mode
set showtabline=2 " status line at top
set autoread " auto reload files from disk
set backspace=eol,indent,start " familiar backspace behavior
set colorcolumn=80 " column limit indicator

" leader mapping
let mapleader = ','

" don't close split on bd
nmap <leader>d :bprevious<CR>:bdelete #<CR>

" manage vimrc
nmap <leader>s :source ~/.vimrc<CR>
nmap <leader>e :e ~/.vimrc<CR>

" rebind save
nn <silent> <leader>w :w<CR>

" rebind escape
" imap jk <Esc>
imap kj <Esc>
imap jj <Esc>

" buffer navigations
nnoremap <C-n> :bnext<cr>
nnoremap <C-b> :bprev<cr>
" nnoremap <leader>d :bd#<CR>

"toggle relative line numbers
nn <silent> <leader>l :call ToggleNumber()<CR>

" toggle colorcolumn
nn <silent> <leader>c :call ToggleColorColumn()<CR>


" put plugins and dictionaries in this dir (also on Windows)
let vimDir = '$HOME/.vim'
let &runtimepath.=','.vimDir " TODO necessary line?

" keep undo history across sessions by storing it in a file
if has('persistent_undo')
    let myUndoDir = expand(vimDir . '/undodir')
    " Create dirs
    call system('mkdir ' . vimDir)
    call system('mkdir ' . myUndoDir)
    let &undodir = myUndoDir
    set undofile
endif

" toggle ling number style
fun! ToggleNumber() "{{{
    if exists('+relativenumber')
        :exec &nu==&rnu? "setl nu!" : "setl rnu!"
    else
        setl nu! 
    endif
endf "}}}

" toggle color column
fun! ToggleColorColumn() "{{{
    if &cc == 80
        :echo "unsetting colorcolumn"
        :exec "set colorcolumn="
    else
        :echo "setting colorcolumn"
        set colorcolumn=80
    endif
endf "}}}

" file type formats
augroup formatting
  autocmd!
  autocmd FileType c ClangFormatAutoEnable
  autocmd BufRead,BufNewFile *.json set filetype=json
  autocmd BufRead,BufNewFile *.htm,*.html setlocal tabstop=8 shiftwidth=2 softtabstop=2
  autocmd FileType python set expandtab shiftwidth=4 softtabstop=0
  autocmd FileType asm set expandtab shiftwidth=8 softtabstop=0 syntax=nasm
  autocmd FileType make set noexpandtab shiftwidth=4 softtabstop=0
  autocmd FileType vue,html,xhtml,css,xml,xslt set shiftwidth=2 softtabstop=2
  autocmd FileType json set autoindent
  autocmd FileType json set formatoptions=tcq2l
  autocmd FileType json set textwidth=78 shiftwidth=2
  autocmd FileType json set softtabstop=2 tabstop=8
  autocmd FileType json set expandtab
  autocmd FileType json set conceallevel=0
augroup END

" PLUGIN CONFIGURATION 

"christoomey/vim-tmux-navigator - split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" itchyny/lightline.vim
let g:lightline = {
       \ 'active': {
       \   'left': [ [ 'mode', 'paste' ],
       \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
       \ },
       \ 'colorscheme': 'gruvbox',
       \ 'component_function': {
       \   'gitbranch': 'fugitive#head'
       \ },
       \ }
let g:lightline.tabline = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

" junegun/fzf - file/buffer navigation with fzf
nnoremap <C-p> :Files<cr>
nnoremap <C-i> :History<cr>
nnoremap <leader>f :Files<cr>
nnoremap <leader>r :History<cr>
nnoremap <leader>t :Tags<cr>
nnoremap <leader>b :Buffers<cr>
nnoremap <leader>l :Lines<cr>
let g:fzf_preview_window = 'right:60%'
" Required to have 'bat' installed
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

" tpope/vim-vinegar - hide dotfiles 'gh' to goggle . hiding
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'

" joe-skb7/cscope-maps - cscope stuff
source ~/.vim/plugged/cscope-maps/plugin/cscope_maps.vim
" use cscope first, then ctags
set cscopetag

" rhysd/vim-clang-format - clang format stuff
map <C-F> :ClangFormat<cr>
imap <C-F> <c-o>:ClangFormat<cr>

" dense-analysis/ale - ale linting 
let g:ale_linters = {'python': ['pylint'], 'c': ['clang']}
let g:ale_python_pylint_options = '--load-plugins pylint_flask,pylint_flask_sqlalchemy'

" tpope/vim-commentary - comment strings
autocmd FileType vue setlocal commentstring=<!--\ %s\ -->
" autocmd FileType c setlocal commentstring=//\ %s
autocmd FileType c setlocal commentstring=/*\ %s\ */

" xolox/vim-easytags - easytags 
" let g:easytags_async = 1

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

"CoC
" let g:coc_disable_startup_warning=1

