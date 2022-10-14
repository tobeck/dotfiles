call plug#begin()
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'christoomey/vim-tmux-navigator'

" Language
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'hashivim/vim-terraform'
Plug 'python-mode/python-mode', { 'branch': 'develop' }

" Colors and styles
Plug 'arcticicestudio/nord-vim'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

" Git
Plug 'tpope/vim-fugitive'

" Lint
Plug 'w0rp/ale'
call plug#end()

let mapleader = ","

" Run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Show line numbers
set number

" Set NERDTree to show hidden files
let NERDTReeShowHidden=1
" Set NERDTree pane size
let g:NERDTreeWinSize=50

" Set python-mode to check syntax for python3
let g:pymode_python = 'python3'

" Python indent
filetype indent plugin on

" 80 chars/line
set textwidth=0
if exists('&colorcolumn')
  set colorcolumn=88
endif

"python with virtualenv support
" py << EOF
" import os
" import sys
" if 'VIRTUAL_ENV' in os.environ:
"   project_base_dir = os.environ['VIRTUAL_ENV']
"   activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"   execfile(activate_this, dict(__file__=activate_this))
" EOF
