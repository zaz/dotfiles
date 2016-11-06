set nocompatible

set backspace=indent,eol,start

set history=1000
set ruler
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.ico

set smartindent
set smarttab
set tabstop=4 softtabstop=4 shiftwidth=4
filetype plugin indent on

set number
set relativenumber
set colorcolumn=80
set complete-=i
set list
" Possibly useful characters: ├—◦›·◬
set listchars=tab:│\ ,trail:\ ,extends:#,nbsp:\  " Highlight problematic whitespace
		" Example.  
set spell
set spelllang=en,ru
set nrformats-=octal  " Never treat numbers as octal when incrementing

set showmatch
set hlsearch
set incsearch
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set scrolloff=2

set splitbelow
set splitright

" Maps:
let mapleader=","
nnoremap <leader>s :update<cr>
nnoremap <space> za
nnoremap <leader>vrc :tabe ~/.vimrc<cr>
augroup vimrchooks
	autocmd!
	autocmd bufwritepost .vimrc "source ~/.vimrc
augroup END

" Show file in split screen
" noremap <silent> <Leader>vs :<C-u>bo vs<CR>Lzt:setl scb<CR><C-w>p:setl scb<CR>
noremap <silent> <Leader>vs :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

" Make arrow keys work as expected on wrapped lines:
noremap  <buffer> <silent> <Up>        gk
noremap  <buffer> <silent> <Down>      gj
noremap  <buffer> <silent> <Home>      g<Home>
noremap  <buffer> <silent> <End>       g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>

noremap  <buffer> <silent> k      gk
noremap  <buffer> <silent> j      gj
noremap  <buffer> <silent> 0      g0
noremap  <buffer> <silent> $      g$

" Plugins:
execute pathogen#infect()
noremap <C-n> :NERDTreeToggle<CR>
set laststatus=2
" noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 1, 1)<CR>
" noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 1, 1)<CR>
" noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 1, 1)<CR>
" noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 1, 1)<CR>
" A simpler alternative:
" noremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
" noremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>
" autocmd BufReadPost * DetectIndent

" set rtp+=/usr/lib/python3.3/site-packages/powerline/bindings/vim
" let $PYTHONPATH = "/usr/lib/python3.3/site-packages"
" python from powerline.vim import setup as powerline_setup
" python powerline_setup()
" python del powerline_setup

syntax on
set background=dark
colorscheme solarized


" Config from SPF13
" -----------------

" Restore cursor to file position in previous editing session
function! ResCur()
	if line("'\"") <= line("$")
		normal! g`"
		return 1
	endif
endfunction

augroup resCur
	autocmd!
	autocmd BufWinEnter * call ResCur()
augroup END


set showmode                    " Display the current mode
set cursorline                  " Highlight current line
" highlight clear SignColumn      " SignColumn should match background
" highlight clear LineNr          " Current line number row will have same background color in relative mode

if has('cmdline_info')
	set ruler                   " Show the ruler
	set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
	set showcmd                 " Show partial commands in status line and
								" Selected characters/lines in visual mode
endif

if has('statusline')
	set laststatus=2

	" Broken down into easily includeable segments
	set statusline=%<%f\                     " Filename
	set statusline+=%w%h%m%r                 " Options
	set statusline+=%{fugitive#statusline()} " Git Hotness
	set statusline+=\ [%{&ff}/%Y]            " Filetype
	set statusline+=\ [%{getcwd()}]          " Current dir
	set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive search when capital letters present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set foldenable                  " Auto fold code

set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)

map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_
nnoremap Y y$

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" let g:airline_theme='solarized'
" let g:airline_left_sep='›'  " Slightly fancier than '>'
" let g:airline_right_sep='‹' " Slightly fancier than '<'
"
map <C-E> :CtrlPClearCache<CR>

" cd to the directory containing the file in the buffer
nmap <silent> ,cd :lcd %:h<CR>
nmap <silent> ,cr :lcd <c-r>=FindGitDirOrRoot()<cr><cr>
nmap <silent> ,md :!mkdir -p %:p:h<CR>

" Turn off that stupid highlight search
nmap <silent> ,n :nohls<CR>


" " XXX Experimental chording
" let g:arpeggio_timeoutlen=3600000
" execute arpeggio#load()
" Arpeggio inoremap uh 0
" Arpeggio inoremap ut 1
" Arpeggio inoremap un 2
" Arpeggio inoremap us 3
" Arpeggio inoremap ug 4
" Arpeggio inoremap uc 5
" Arpeggio inoremap ur 6
" Arpeggio inoremap ub 7
" Arpeggio inoremap um 8
" Arpeggio inoremap uw 9


" Russian mappings - XXX won't work because symbols are included as well
" inoremap ё `
" inoremap - [
" inoremap = ]

" inoremap й '
" inoremap ц ,
" inoremap у .
" inoremap к p
" inoremap е y
" inoremap н f
" inoremap г g
" inoremap ш c
" inoremap щ r
" inoremap з l
" inoremap х /
" inoremap ъ =
" inoremap ф a
" inoremap ы o
" inoremap в e
" inoremap а u
" inoremap п i
" inoremap р d
" inoremap о h
" inoremap л t
" inoremap д n
" inoremap ж s
" inoremap э -
" inoremap \ #
" inoremap / \
" inoremap я ;
" inoremap ч q
" inoremap с j
" inoremap м k
" inoremap и x
" inoremap т b
" inoremap ь m
" inoremap б w
" inoremap ю v
" inoremap . z

" inoremap Й '
" inoremap Ц ,
" inoremap У .
" inoremap К P
" inoremap Е Y
" inoremap Н F
" inoremap Г G
" inoremap Ш C
" inoremap Щ R
" inoremap З L
" inoremap Х /
" inoremap Ъ =
" inoremap Ф A
" inoremap Ы O
" inoremap В E
" inoremap А U
" inoremap П I
" inoremap Р D
" inoremap О H
" inoremap Л T
" inoremap Д N
" inoremap Ж S
" inoremap Э -
" inoremap \ #
" inoremap / \
" inoremap Я ;
" inoremap Ч Q
" inoremap С J
" inoremap М K
" inoremap И X
" inoremap Т B
" inoremap Ь M
" inoremap Б W
" inoremap Ю V
" inoremap . Z

" inoremap Ё ¬
" inoremap ! !
" inoremap " "
" inoremap № £
" inoremap ; $
" inoremap % %
" inoremap : ^
" inoremap ? &
" inoremap * *
" inoremap ( (
" inoremap ) )
" inoremap _ {
" inoremap + }
