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
" Plug 'Quramy/tsuquyomi'
Plug 'Vadskye/vim-meta'
Plug 'Vadskye/vim-psql', {'for': 'sql'}
Plug 'elzr/vim-json'
call plug#end()

set ignorecase
set smartcase


" How can I close vim if the only window left open is a NERDTree?
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Jump directly to line
nnoremap <CR> G

" Map FZF to ;
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
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
let g:ag_qhandler="copen 30"

" Ale 
nnoremap gd :ALEGoToDefinition<CR>
nnoremap gr :ALEFindReferences<CR>
nnoremap gh :ALEHover<CR>
highlight clear ALEError
let g:ale_linters = {
      \   'javascript': ['eslint', 'tsserver'],
      \   'typescript': ['tslint', 'tsserver']
      \}
let g:ale_fixers = {
      \'javascript': ['prettier', 'eslint', 'remove_trailing_lines', 'trim_whitespace'],
      \'typescript': ['prettier','tslint', 'remove_trailing_lines', 'trim_whitespace']
      \}
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_delay = 500

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
nnoremap gp :let @+ = expand('%')<CR>

" Airline powerline symbols
let g:airline_powerline_fonts = 1

" Use # to return to previous file
nnoremap # :e #<CR>

" UltiSnips:
let g:UltiSnipsSnippetsDir = $DOTFILES . '/vim/UltiSnips'
" manually specify snippet directory for speed
let g:UltiSnipsSnippetDirectories=[$DOTFILES . '/vim/UltiSnips']

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Sort current selection
vnoremap gs :'<,'>!sort<CR>
function! SortLevel() abort
    let first_line = getline("'<")
    let last_line = getline("'>")
    let spaces = matchstr(first_line, '\v^( +)')
    silent! execute "'<,'>s%\\v\\n" . spaces . " +([^ ].*)\\_$(\\n" . spaces . "([^ ]))?%\\1 \\3%g"
    '<,'>!sort
endfunction
" Sort the current indentation level, creactively smashing indented objects
" This works best on code that can be automatically parsed back out, such as
" with Prettier.
nmap gl Vii<Esc>:call SortLevel()<CR>
vnoremap gl <Esc>:call SortLevel()<CR>


set sidescroll=1

" JSON formatting
command! JsonFormat %!python -m json.tool
