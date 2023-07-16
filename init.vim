" You need pip install neovim in any virtualenv for Ultisnips to work
" Force vim to load python3 before python2
"if has('python3')
"endif

"NOTE for Neovim users: If Neovim finds python on your $PATH, it assumes this is Python 2 (and likewise for python3 being treated as Python 3). If you start Neovim from a shell with an activated Conda env that uses Python 3, you're going to have problems because the conda env exposes a binary called python, but which is really 3 and not 2. Because of this, you will have to use the Neovim option of setting g:python_host_prog to point to a valid Python 2, into which you must also have pip installed the required neovim client.
" see https://github.com/cjrh/vim-conda
"let g:python_host_prog='/usr/bin/python2'
" let g:python3_host_prog='/home/christof/miniconda3/envs/zml-py/bin/python'
"let g:python3_host_prog='/usr/bin/xpython'


"if $CONDA_PREFIX == ""
"  let s:current_python_path=$CONDA_PYTHON_EXE
"else
"  let s:current_python_path=$CONDA_PREFIX.'/bin/python'
"endif


set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
"Plugin 'git://git.wincent.com/command-t.git'
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'sakhnik/nvim-gdb'
" Plugin 'w0rp/ale'
"Plugin 'tpope/vim-commentary'
Plugin 'tmhedberg/SimpylFold'
" Plugin 'vim-scripts/indentpython.vim'
Plugin 'preservim/nerdtree'
Plugin 'aklt/plantuml-syntax'
"Plugin 'davidhalter/jedi-vim'
"Plugin 'kana/vim-textobj-user'
"Plugin 'bps/vim-textobj-python'
Plugin 'kien/ctrlp.vim'
Plugin 'morhetz/gruvbox'
" Plugin 'vim-python/python-syntax'
" Plugin 'ludovicchabant/vim-gutentags'
Plugin 'stsewd/isort.nvim'
"Plugin 'fisadev/vim-isort'
"Plugin 'editorconfig/editorconfig-vim'
"Plugin 'iamcco/markdown-preview.nvim'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'
Plugin 'honza/vim-snippets'
Plugin 'andrewstuart/vim-kubernetes'
"Plugin 'StanAngeloff/php.vim'
"Plugin 'stephpy/vim-php-cs-fixer'
"Plugin 'ncm2/ncm2'
" Plugin 'nvie/vim-flake8'
" Plugin 'vim-syntastic/syntastic'
"Plugin 'Shougo/deoplete.nvim'
"Plugin 'deoplete-plugins/deoplete-jedi'
"Plugin 'majutsushi/tagbar'
Plugin 'elzr/vim-json'
Plugin 'ervandew/supertab'
"Plugin 'chriskempson/tomorrow-theme'
"Plugin 'junegunn/fzf.vim'
"Plugin 'roxma/nvim-yarp'
"Plugin 'ncm2/ncm2-bufword'
"Plugin 'ncm2/ncm2-path'
"Plugin 'ncm2/ncm2-tmux'
"Plugin 'pacha/vem-tabline'
Plugin 'pacha/vem-statusline'
Plugin 'pedrohdz/vim-yaml-folds'
Plugin 'python-mode/python-mode'
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" set shell

" set shell=/bin/zsh

" nvim-gdb key mappings

" We're going to define single-letter keymaps, so don't try to define them
" in the terminal window.  The debugger CLI should continue accepting text commands.
function! NvimGdbNoTKeymaps()
  tnoremap <silent> <buffer> <esc> <c-\><c-n>
endfunction

let g:nvimgdb_config_override = {
  \ 'key_next': 'n',
  \ 'key_step': 's',
  \ 'key_finish': 'f',
  \ 'key_continue': 'c',
  \ 'key_until': 'u',
  \ 'key_breakpoint': 'b',
  \ 'set_tkeymaps': "NvimGdbNoTKeymaps",
  \ }

"call coc#config('python', {'pythonPath': s:current_python_path})

" ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" gruvbox
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
set background=dark

" backup dirs
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" automatic insertion of header gates
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef __" . gatename . "__"
  execute "normal! o#define __" . gatename . "__ "
  execute "normal! Go#endif /* " . gatename . " */"
  normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" airline
set laststatus=2
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_theme='tomorrow'
let g:airline#extensions#tabline#enabled = 1 " Use the airline tabline (replacement for buftabline)
let g:airline#extensions#tabline#excludes = ['branches', 'index']
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#ale#enabled = 1

" system clipboard
set clipboard=unnamedplus

" syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['pylint']  "" or ['flake8', 'pylint'], etc
let g:syntastic_python_pylint_args = '-E'
"" to show it accepts a string of args, also:
let g:syntastic_python_pylint_args = '--rcfile=/path/to/rc -E'

" next
nnoremap <c-n> :lnext<CR>

map <leader>e :call SyntasticToggle()<CR>

let g:syntastic_is_open = 0  
function! SyntasticToggle()
if g:syntastic_is_open == 1
    lclose
    let g:syntastic_is_open = 0 
else
    lopen
    let g:syntastic_is_open = 1 
endif
endfunction

" python mode setup
" https://realpython.com/vim-and-python-a-match-made-in-heaven/

" Enable folding
set foldmethod=indent
set foldlevel=99

" Enable folding with the spacebar
nnoremap <space> za
let g:SimpylFold_docstring_preview=1


" indents
set tabstop=4
set softtabstop=4
" when indenting with '>', use 2 spaces width
set shiftwidth=4
set expandtab

autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=119 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

au BufNewFile,BufRead *.js, *.html, *.css, *.zml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |

set encoding=utf-8

" autocomplete
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']

" fzf
set rtp+=~/.fzf

" autocompletion ncm2
" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" NOTE: you need to install completion sources to get completions. Check
" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki

" PHP IDE
set number nu
set cursorline
set smartindent

" nerdtree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

let g:NERDTreeWinSize=42

" php complete
let g:phpcomplete_mappings = {
   \ 'jump_to_def': '<C-]>',
   \ 'jump_to_def_split': '<C-W><C-]>',
   \ 'jump_to_def_vsplit': '<C-W><C-\>',
   \ 'jump_to_def_tabnew': '<C-W><C-[>',
   \}

"let $PATH=$PATH . ':' . expand('~/.composer/vendor/bin')
" autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

"set completeopt=longest,menuone
let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

" tags
"au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" php
" fix slow ctags
set tags=tags
set path=.
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>
" Invoke the context menu
nmap <Leader>mm :call phpactor#ContextMenu()<CR>
" Invoke the navigation menu
nmap <Leader>nn :call phpactor#Navigate()<CR>
" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>
" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>
" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>
" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" Extract expression from selection
vmap <silent><Leader>ee :<C-U>call phpactor#ExtractExpression(v:true)<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>

let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_dry_run = 0
let g:php_cs_fixer_verbose = 0

" neomake
let g:neomake_open_list = 2

" diffopt
set diffopt+=vertical

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-tab>"

" editorconfig
" Excluded patterns.
" To ensure that this plugin works well with Tim Pope's fugitive, use the following patterns array:
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" ctags for php
au BufWritePost *.php silent! !eval '[ -f ".git/hooks/ctags" ] && .git/hooks/ctags' &

" tagbar config
nmap <F8> :TagbarToggle<CR>
let g:tagbar_left=1
let g:tagbar_width=50
let g:tagbar_iconchars=['▸', '▾']
au FileType go nested :TagbarOpen

" pytest.vim
let g:pytest_open_errors = 'current'

" vdebug

let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<F9>",
\    "step_over" : "<F2>",
\    "step_into" : "<F3>",
\    "step_out" : "<F4>",
\    "close" : "F6",
\    "detach" : "<F7>",
\    "set_breakpoint" : "<F10>",
\    "get_context" : "<leader>c",
\    "eval_under_cursor" : "<leader>f",
\    "eval_visual" : "<Leader>e"
\}

" conda startup messafes suppress
let g:conda_startup_msg_suppress = 1

" shortcuts

" set breakpoint
nmap <Leader>b :Breakpoint<CR>

" pdb
cnoreabbrev pdb GdbStartPDB 

" fzf find 
nnoremap <Leader><Space> :Files<CR>
nnoremap <silent> <Leader>o :Files<CR>
nnoremap <silent> <Leader>O :Files!<CR>

" buftabline numbers
let g:buftabline_numbers = 1
let g:buftabline_indicators = 1
let g:buftabline_separators = 1

" set hidden

set hidden

" vem tabline
let g:vem_tabline_show_number = 'buffnr'

" jedi disable autocomplete (use coc-python instead)
let g:jedi#completions_enabled = 0

" gutentags exclude certain filetypes (these lead to errors)
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git']

" XML folding

augroup XML
    autocmd!
    autocmd FileType xml setlocal foldmethod=indent foldlevelstart=999 foldminlines=0
augroup END

let python_highlight_all=1
syntax on

let g:airline_theme='solarized'

" air-line
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

set background=dark
let &t_8f = "\e[38;2;%lu;%lu;%lum"
let &t_8b = "\e[48;2;%lu;%lu;%lum"
set t_Co=256
set termguicolors

" jedi
"
let g:jedi#auto_initialization = 1

let g:ale_completion_enabled = 1
let g:ale_completion_delay = 200
let g:ale_completion_jedi_use_splits = 0
let g:ale_completion_jedi_use_echo = 0

" autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" autocmd FileType python setlocal omnifunc=deoplete#complete

let g:vim_isort_map = '<C-i>'

let g:pymode_options_max_line_length = 140

" let g:pymode_lint_checkers = ['pylint', 'pyflakes', 'pycodestyle', 'mccabe']

"let g:pymode_lint_select = ["W0612"]
let g:pymode_rope = 1
let g:pymode_rope_prefix = '<C-c>'

let ropevim_vim_completion = 1
let ropevim_extended_complete = 1
let ropevim_autoimport_modules = ["os.*", "podman.*"]
let ropevim_autoimport_ask_modules = 1
