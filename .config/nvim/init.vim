syntax on                   " Enable syntax highlighting.
filetype plugin indent on   " Enable file type based indentation.
set autoindent              " Respect indentation when starting a new line.
set expandtab               " Expand tabs to spaces. Essential in Python.
set tabstop=4               " Number of spaces tab is counted for.
set shiftwidth=4            " Number of spaces to use for autoindent.
set backspace=2             " Fix backspace behavior on most terminals.
set noswapfile              " Avoids save swapfile
set undofile                " persist undo history between sessions
set foldmethod=indent       " Change fold method to indent
set foldcolumn=1            " To visualize where folds are
set wildmenu                " Enable enhanced tab autocomplete
set wildmode=list:longest,full  " Complete till longest string,
                                " then open the wildmenu
set number                  " Enable number lines
set relativenumber          " Enable relative number lines
set hlsearch                " Highlight search matches
set incsearch               " Put the cursor in the first match
set clipboard=unnamed,unnamedplus  " Copy into system (*, +) register.
" set spell                   " Check Spell
set tags=tags;              " Look for a tags file recursively in parent directories.
" Syntastic pylint configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_pylint_exe = 'pylint'

colorscheme elflord          " Change a colorscheme.

packloadall                 " Load all plugins
silent! helptags ALL        " Load help files for all plugins

" Fast split navigation with <Ctrl> + hjkl.
noremap <c-h> <c-w><c-h>
noremap <c-j> <c-w><c-j>
noremap <c-k> <c-w><c-k>
noremap <c-l> <c-w><c-l>

" Set CtrlP working directory to a repository root (with a fallback to current directory).
let g:ctrlp_working_path_mode = 'ra'

" Run test with dispatch in a different window
let test#strategy = "dispatch"

" Remap CtrlP actions to be prefixed by a leader key. 
noremap <leader>p :CtrlP<cr> 
noremap <leader>b :CtrlPBuffer<cr> 
noremap <leader>m :CtrlPMRU<cr>

" Jump to function definition
noremap <leader>] :YcmCompleter GoTo<cr>

noremap <leader>w :w<cr>    " Save a file with leader-w
" Immediatly add a closing quotes or braces in insert mode.
inoremap ' ''<esc>i
inoremap " ""<esc>i
inoremap ( ()<esc>i
inoremap { {}<esc>i
inoremap [ []<esc>i
nnoremap <F5> :GundoToggle<CR> " Map Gundo to <F5>.
tnoremap <Esc> <C-\><C-n>
command! Bd :bp | :sp | :bn | :bd  " Close buffer without closing window.

autocmd BufRead * normal zR     " Keep folds open
" Regenerate tags when saving Python files.
autocmd BufWritePost *.py silent! !ctags -R &
" Regenerate tags when saving C++ files.
autocmd BufWritePost *.cpp,*.h silent! !ctags -R &

" Use :make to run pylint for Python files.
autocmd filetype python setlocal makeprg=pylint\ --reports=n\ --msg-template=\"{path}:{line}:\ {msg_id}\ {symbol},\ {obj}\ {msg}\"\ %:p
autocmd filetype python setlocal errorformat=%f:%l:\ %m

" autocmd VimEnter * NERDTree     " Enable NERDTree on Vim Startup
" Autoclose NERDTree if it's the only open window left.
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
" \ b:NERDTree.isTabTree()) | q | endif

" NERDTree
" let NERDTreeShowBookmarks = 1   " Display bookmarks on startup

" Manage plugins with vim-plug.
" Install vim-plug if it's not already installed.
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs 
         \ https://raw.github.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

Plug 'junegunn/vim-plug'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
let g:plug_timeout = 300  " Increase vim-plug timeout for YouCompleteMe.
Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-dispatch'
Plug 'janko-m/vim-test'
Plug 'vim-syntastic/syntastic'
Plug 'vim-airline/vim-airline'

call plug#end()
