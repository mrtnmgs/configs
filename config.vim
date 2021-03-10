" Point to this file in ~/.vimrc :
" source ~/path/to/this/file

" GENERAL
syntax on

" automatically refresh buffers if they change externally
" and there are no unsaved changes
set autoread

" Clear highlighting on escape in normal mode
nnoremap <esc> :noh<return><esc>
nnoremap <esc>^[ <esc>^[

set number relativenumber

" nice trick to get relative numbers when the file is in focus and absolute
" otherwise
" from https://jeffkreeftmeijer.com/vim-number/
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

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
" use space as leader key (normal mode)
let mapleader = " "

" FILE TYPES
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
autocmd BufNewFile,BufFilePre,BufRead *.ly set filetype=lilypond


" PLUGINS - VIM-PLUG 
call plug#begin('~/.vim/plugged')

" Fuzzy finder
Plug 'vim-airline/vim-airline'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Language support (incl. syntax highlighting)
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
"    Elm 
Plug 'elmcast/elm-vim'
"    Elixir
Plug 'elixir-editors/vim-elixir'

" Code formatting
Plug 'prettier/vim-prettier', { 'do': 'npm install' }

" Theme
Plug 'ajmwagar/vim-deus'
Plug 'sonph/onehalf', { 'rtp': 'vim' }
Plug 'joshdick/onedark.vim'

" Asynchronous Lint Engine
" Plug 'w0rp/ale'

Plug 'supercollider/scvim'

call plug#end()

" colors deus
" colorscheme onehalfdark
colorscheme onedark

" Prettier - JavaScript formatter
autocmd FileType javascript set formatprg=prettier\ --stdin
autocmd FileType typescript set formatprg=prettier\ --parser\ typescript
" run only if there's a prettier config file:
" let g:prettier#autoformat_config_present = 1
let g:prettier#autoformat_require_pragma = 0
" run always:
let g:prettier#autoformat = 1
" mapping to run prettier
nmap <leader>p <Plug>(Prettier)


" MISC
"
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
"
" search in the current directory
command! -bang CurDirFiles call fzf#vim#files('./', <bang>0)
" alias ctrl + p to CurDirFiles
nmap <C-P> :CurDirFiles<CR>
