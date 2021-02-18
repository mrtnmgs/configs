" Just add this to ~/.vimrc with:
" source ~/path/to/this/file

" SYNTAX COLORING
syntax on

"
" INDENTATION
filetype plugin indent on
" show existing tab with 2 spaces width
set tabstop=2
" when indenting with '>', use 2 spaces width
set shiftwidth=2
" On pressing tab, insert 2 spaces
set expandtab


" KEY MAPPINGS 
let mapleader="\<SPACE>"
"open Vim Config
:nnoremap <leader>vc :vsplit $MYVIMRC<cr>
"Source Config file
:nnoremap <leader>sc :source $MYVIMRC<cr>
" text after cursor to next line
:nnoremap <leader>j i<cr><esc>


" FILE TYPES
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
autocmd BufNewFile,BufFilePre,BufRead *.ly set filetype=lilypond


" PLUGINS - VIM-PLUG 
call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
"    html
Plug 'othree/html5.vim'
"    css
Plug 'hail2u/vim-css3-syntax'
"    js
" Plug 'pangloss/vim-javascript'
"    better js support
Plug 'yuezk/vim-js'
"    tsx 
Plug 'HerringtonDarkholme/yats.vim'
"    jsx 
Plug 'maxmellon/vim-jsx-pretty'
"    Elm (more than syntax)
Plug 'elmcast/elm-vim'

" Code formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Theme
Plug 'ajmwagar/vim-deus'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'

" Asynchronous Lint Engine
" Plug 'w0rp/ale'

" Deoplete - Auto-completion framework
" (+ flow autocompletion)
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'wokalski/autocomplete-flow'
" Plug 'Shougo/neosnippet'
" Plug 'Shougo/neosnippet-snippets'

" Conquer of Completion
" !! conflicts with deoplete
Plug 'neoclide/coc.nvim', {'branch': 'release'} 

Plug 'supercollider/scvim'

call plug#end()

" colors deus
" colorscheme onehalfdark
colorscheme onedark

" Prettier - JavaScript formatter
autocmd FileType javascript set formatprg=prettier\ --stdin

" Enable Deoplete at startup
let g:deoplete#enable_at_startup = 1


" MISC
let g:pymode_python = 'python3'

" Pressing F8 executes the python file being edited
autocmd FileType python map <buffer> <F8> :w<CR>:exec '!python3' shellescape(@%, 1)<CR>
autocmd FileType python imap <buffer> <F8> <esc>:w<CR>:exec '!python3' shellescape(@%, 1)<CR>

" SuperCollider
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au Filetype supercollider packadd scvim

:if $VIM_CRONTAB == "true"
:set nobackup
:set nowritebackup
:endif

" FZF
" search in the Dev directory
command! -bang DevFiles call fzf#vim#files('~/Dev', <bang>0)

" search in the current directory
command! -bang CurDirFiles call fzf#vim#files('./', <bang>0)
" alias ctrl + p to CurDirFiles
nmap <C-P> :CurDirFiles<CR>
