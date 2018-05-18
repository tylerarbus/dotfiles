" Install vim plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'coot/CRDispatcher'
Plug 'tpope/vim-sensible'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'leafgarland/typescript-vim'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf'
Plug 'scrooloose/nerdtree'
Plug 'w0rp/ale'
Plug 'Raimondi/delimitMate'
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'yegappan/mru'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'coot/EnchantedVim'
Plug 'mhinz/vim-startify'
Plug 'skielbasa/vim-material-monokai'
Plug 'SirVer/ultisnips'
call plug#end()

set ignorecase
set smartcase


" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Jump directly to line
nnoremap <CR> G

" Map FZF to ;
map ; :FZF<CR>

" Set tab and autoindent to 2 spaces
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Highlight cursor line
set cursorline
hi CursorLine cterm=NONE ctermbg=darkgray

" Auto create closing brackets
inoremap <C-j> <Esc>/[)}"'\]>]<CR>:nohl<CR>a

" delimitMate
let delimitMate_expand_cr = 1 
let delimitMate_jump_expansion = 1

let g:deoplete#enable_at_startup = 1

" [alt] + hjkl to move lines
nnoremap ∆ :m .+1<CR>==
nnoremap ˚ :m .-2<CR>==
inoremap ∆ <Esc>:m .+1<CR>==gi
inoremap ˚ <Esc>:m .-2<CR>==gi
vnoremap ∆ :m '>+1<CR>gv=gv
vnoremap ˚ :m '<-2<CR>gv=gv

" Use ag for search
let g:ackprg = 'ag --nogroup --nocolor --smart-case --column -C 2'
" let g:ackhighlight = 1

" Ale 
nnoremap gd :ALEGoToDefinition<CR>
highlight clear ALEError

" Color scheme
set background=dark
set termguicolors
colorscheme material-monokai
let g:airline_theme='materialmonokai'

" Don't go to first result in Ack
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space><Paste>

" Find replace
nnoremap s :.,$s%%%cg<Left><Left><Left><Left>
nnoremap s* "syiw:.,$s%%%cg<Left><Left><Left><Left><<C-R>s><Right><Paste>

" Toggle Nerdtree
map <C-n> :NERDTreeToggle<CR>

" Enable mouse
set mouse=a

" Use system clipboard
set clipboard=unnamed

" Enchanted vim
let g:VeryMagic=0
let g:VeryMagicSubstitute=1
let g:VeryMagicGlobal=0
let g:VeryMagicVimGrep=1
let g:VeryMagicSearchArg=1
let g:VeryMagicFunction=1
let g:VeryMagicHelpgrep=1
let g:VeryMagicRange=1

" Startify session handling
let g:startify_session_persistence = 1
let g:startify_session_sort = 1
let g:startify_session_autoload = 1
let NERDTreeHijackNetrw = 1

" Set line numbers
set number

" Mapping for copying current file path
nnoremap cp :let @+ = expand('%')<CR>

" Airline powerline symbols
let g:airline_powerline_fonts = 1

" Use # to return to previous file
nnoremap # :e #<CR>

" UltiSnips:
" better key bindings for UltiSnipsExpandTrigger
if has('unix')
    " hack to get around inability to detect shift-enter
    let g:UltiSnipsExpandTrigger = "<Linefeed>"
    let g:UltiSnipsJumpForwardTrigger = "<Linefeed>"
    let g:UltiSnipsJumpBackwardTrigger = "<C-Enter>"
else
    let g:UltiSnipsExpandTrigger = "<S-Enter>"
    let g:UltiSnipsJumpForwardTrigger = "<S-Enter>"
    let g:UltiSnipsJumpBackwardTrigger = "<C-Enter>"
endif
