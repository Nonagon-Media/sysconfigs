set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" ctrl-p
Plugin 'ctrlpvim/ctrlp.vim'

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'jistr/vim-nerdtree-tabs'

" Vimairline status bar
Plugin 'vim-airline/vim-airline'

"Syntastic syntax checker
Plugin 'scrooloose/syntastic'

"Shellcheck
Plugin 'koalaman/shellcheck'

"Vim-surround quoting tool
Plugin 'tpope/vim-surround'

" autocompletion tool
Plugin 'ajh17/vimcompletesme'


" Whitespace fixer
Plugin 'bronson/vim-trailing-whitespace'

" Symbol comletion for () {}, etc
Plugin 'raimondi/delimitmate'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
"Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
"Plugin 'ascenator/L9', {'name': 'newL9'}

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
"
" Keybindings
map <silent> <C-n> :NERDTreeToggle<CR>

" xoria settings
" Initialization {{{
if &t_Co != 256 && ! has("gui_running")
  echomsg ""
  echomsg "err: please use GUI or a 256-color terminal (so that t_Co=256 could be set)"
  echomsg ""
  finish
endif

set background=dark

hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "xoria256"
"}}}
" Colours {{{1
"" General {{{2
hi Normal       ctermfg=252 guifg=#d0d0d0 ctermbg=234 guibg=#1c1c1c cterm=none gui=none
hi Cursor                                 ctermbg=214 guibg=#ffaf00
hi CursorColumn                           ctermbg=238 guibg=#444444
hi CursorLine                             ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi Error        ctermfg=15  guifg=#ffffff ctermbg=1   guibg=#800000
hi ErrorMsg     ctermfg=15  guifg=#ffffff ctermbg=1   guibg=#800000
hi FoldColumn   ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212
hi Folded       ctermfg=255 guifg=#eeeeee ctermbg=60  guibg=#5f5f87
hi IncSearch    ctermfg=0   guifg=#000000 ctermbg=223 guibg=#ffdfaf cterm=none gui=none
hi LineNr       ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212
hi MatchParen   ctermfg=188 guifg=#dfdfdf ctermbg=68  guibg=#5f87df cterm=bold gui=bold
" TODO
" hi MoreMsg
hi NonText      ctermfg=247 guifg=#9e9e9e ctermbg=233 guibg=#121212 cterm=bold gui=bold
hi Pmenu        ctermfg=0   guifg=#000000 ctermbg=250 guibg=#bcbcbc
hi PmenuSel     ctermfg=255 guifg=#eeeeee ctermbg=243 guibg=#767676
hi PmenuSbar                              ctermbg=252 guibg=#d0d0d0
hi PmenuThumb   ctermfg=243 guifg=#767676
hi Search       ctermfg=0   guifg=#000000 ctermbg=149 guibg=#afdf5f
hi SignColumn   ctermfg=248 guifg=#a8a8a8
hi SpecialKey   ctermfg=77  guifg=#5fdf5f
hi SpellBad     ctermfg=160 guifg=fg      ctermbg=bg                cterm=underline               guisp=#df0000
hi SpellCap     ctermfg=189 guifg=#dfdfff ctermbg=bg  guibg=bg      cterm=underline gui=underline
hi SpellRare    ctermfg=168 guifg=#df5f87 ctermbg=bg  guibg=bg      cterm=underline gui=underline
hi SpellLocal   ctermfg=98  guifg=#875fdf ctermbg=bg  guibg=bg      cterm=underline gui=underline
hi StatusLine   ctermfg=15  guifg=#ffffff ctermbg=239 guibg=#4e4e4e cterm=bold gui=bold
hi StatusLineNC ctermfg=249 guifg=#b2b2b2 ctermbg=237 guibg=#3a3a3a cterm=none gui=none
hi TabLine      ctermfg=fg  guifg=fg      ctermbg=242 guibg=#666666 cterm=none gui=none
hi TabLineFill  ctermfg=fg  guifg=fg      ctermbg=237 guibg=#3a3a3a cterm=none gui=none
" FIXME
hi Title        ctermfg=225 guifg=#ffdfff
hi Todo         ctermfg=0   guifg=#000000 ctermbg=184 guibg=#dfdf00
hi Underlined   ctermfg=39  guifg=#00afff                           cterm=underline gui=underline
hi VertSplit    ctermfg=237 guifg=#3a3a3a ctermbg=237 guibg=#3a3a3a cterm=none gui=none
" hi VIsualNOS    ctermfg=24  guifg=#005f87 ctermbg=153 guibg=#afdfff cterm=none gui=none
" hi Visual       ctermfg=24  guifg=#005f87 ctermbg=153 guibg=#afdfff
hi Visual       ctermfg=255 guifg=#eeeeee ctermbg=96  guibg=#875f87
" hi Visual       ctermfg=255 guifg=#eeeeee ctermbg=24  guibg=#005f87
hi VisualNOS    ctermfg=255 guifg=#eeeeee ctermbg=60  guibg=#5f5f87
hi WildMenu     ctermfg=0   guifg=#000000 ctermbg=150 guibg=#afdf87 cterm=bold gui=bold

"" Syntax highlighting {{{2
hi Comment      ctermfg=244 guifg=#808080
hi Constant     ctermfg=229 guifg=#ffffaf
hi Identifier   ctermfg=182 guifg=#dfafdf                           cterm=none
hi Ignore       ctermfg=238 guifg=#444444
hi Number       ctermfg=180 guifg=#dfaf87
hi PreProc      ctermfg=150 guifg=#afdf87
hi Special      ctermfg=174 guifg=#df8787
hi Statement    ctermfg=110 guifg=#87afdf                           cterm=none gui=none
hi Type         ctermfg=146 guifg=#afafdf                           cterm=none gui=none

"" Special {{{2
""" .diff {{{3
hi diffAdded    ctermfg=150 guifg=#afdf87
hi diffRemoved  ctermfg=174 guifg=#df8787
""" vimdiff {{{3
hi diffAdd      ctermfg=bg  guifg=bg      ctermbg=151 guibg=#afdfaf
"hi diffDelete   ctermfg=bg  guifg=bg      ctermbg=186 guibg=#dfdf87 cterm=none gui=none
hi diffDelete   ctermfg=bg  guifg=bg      ctermbg=246 guibg=#949494 cterm=none gui=none
hi diffChange   ctermfg=bg  guifg=bg      ctermbg=181 guibg=#dfafaf
hi diffText     ctermfg=bg  guifg=bg      ctermbg=174 guibg=#df8787 cterm=none gui=none
""" HTML {{{3
" hi htmlTag      ctermfg=146  guifg=#afafdf
" hi htmlEndTag   ctermfg=146  guifg=#afafdf
hi htmlTag      ctermfg=244
hi htmlEndTag   ctermfg=244
hi htmlArg	ctermfg=182  guifg=#dfafdf
hi htmlValue	ctermfg=187  guifg=#dfdfaf
hi htmlTitle	ctermfg=254  ctermbg=95
" hi htmlArg	ctermfg=146
" hi htmlTagName	ctermfg=146
" hi htmlString	ctermfg=187
""" django {{{3
hi djangoVarBlock ctermfg=180
hi djangoTagBlock ctermfg=150
hi djangoStatement ctermfg=146
hi djangoFilter ctermfg=174
""" python {{{3
hi pythonExceptions ctermfg=174
""" NERDTree {{{3
hi Directory      ctermfg=110  guifg=#87afdf
hi treeCWD        ctermfg=180  guifg=#dfaf87
hi treeClosable   ctermfg=174  guifg=#df8787
hi treeOpenable   ctermfg=150  guifg=#afdf87
hi treePart       ctermfg=244  guifg=#808080
hi treeDirSlash   ctermfg=244  guifg=#808080
hi treeLink       ctermfg=182  guifg=#dfafdf

""" VimDebug {{{3
" FIXME
" you may want to set SignColumn highlight in your .vimrc
" :help sign
" :help SignColumn

" hi currentLine term=reverse cterm=reverse gui=reverse
" hi breakPoint  term=NONE    cterm=NONE    gui=NONE
" hi empty       term=NONE    cterm=NONE    gui=NONE

" sign define currentLine linehl=currentLine
" sign define breakPoint  linehl=breakPoint  text=>>
" sign define both        linehl=currentLine text=>>
" sign define empty       linehl=empty
" end xoria settings

" Display line numbers by default and set true color
set t_Co=256
set number

" Tabstops
autocmd BufNewFile,BufRead *.yml set filetype=yaml
autocmd Filetype yaml setlocal expandtab tabstop=1 shiftwidth=1 softtabstop=1
set expandtab
set tabstop=1
set shiftwidth=1
set softtabstop=1

autocmd BufNewFile,BufRead *.pp set filetype=puppet
autocmd Filetype puppet setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd BufNewFile,BufRead *.py set filetype=python
autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd BufNewFile,BufRead *.pl set filetype=perl
autocmd Filetype perl setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd BufNewFile,BufRead *.sh set filetype=bash
autocmd Filetype bash setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

autocmd BufNewFile,BufRead *.rb set filetype=ruby
autocmd Filetype bash setlocal expandtab tabstop=4 shiftwidth=2 softtabstop=2
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

" Plugin Options
"
" vimcompletesme: complete by tag
autocmd FileType text,markdown let b:vcm_tab_complete = 'tags'
