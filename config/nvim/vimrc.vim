" GENERAL SETTINGS
set number	
set wrap
set linebreak
set textwidth=0
set wrapmargin=0
set nospell 
set smartcase 
set ignorecase 
set incsearch
set autoindent
set autochdir
set shiftwidth=4
set smartindent
set smarttab
set hidden
set softtabstop=4
set undolevels=1000
set timeoutlen=1000
set ttimeoutlen=10
set backspace=indent,eol,start
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set laststatus=2
set splitbelow
set splitright
set noshowmode
set fillchars+=eob:\ 
syntax on
colorscheme rem
let mapleader = " "


" NATURAL UP AND DOWN
map j gj
map k gk


" MOVING TEXT
vnoremap J :m '>+1<cr>gv=gv
vnoremap K :m '<-2<cr>gv=gv
vnoremap H <gv
vnoremap L >gv


" TOGGLE COMMENTS
autocmd FileType c,cpp,java,scala  let b:comment_leader = '//'
autocmd FileType javascript        let b:comment_leader = '//'
autocmd FileType solidity          let b:comment_leader = '//'
autocmd FileType sh,ruby,python    let b:comment_leader = '#'
autocmd FileType conf,fstab        let b:comment_leader = '#'
autocmd FileType tex               let b:comment_leader = '%'
autocmd FileType mail              let b:comment_leader = '>'
autocmd FileType vim               let b:comment_leader = '"'
function! CommentToggle()
    execute ':silent! s/\([^ ]\)/' . escape(b:comment_leader,'\/') . ' \1/'
    execute ':silent! s/^\( *\)' . escape(b:comment_leader,'\/') . ' \?' . escape(b:comment_leader,'\/') . ' \?/\1/'
endfunction
map gcc :call CommentToggle()<CR>


" REPLACING WORD UNDER THE CURSOR
nnoremap <leader>n *``cgn
nnoremap <leader>N *``cgN


" COPY INTO REGULAR CLIPBOARD
noremap <C-y> :w !xclip -i -sel c<cr><cr> 
set clipboard=unnamedplus


" CHANGE CURSOR DEPENDING ON THE MODE
let &t_SI = "\e[5 q"
let &t_EI = "\e[2 q"


" SAVE AND COMPILE
map <leader>cl :w<cr> :!pdflatex %:r.tex && rm %:r.aux %:r.log %:r.nav %:r.out %:r.snm %:r.toc<cr>
map <leader>cm :w<cr> :!pandoc -s -o %:r.pdf %:r.md --pdf-engine=xelatex --variable CJKmainfont=KaiTi -V fontsize=12pt -V geometry:margin=2cm<cr>
map <leader>cp :w<cr> :!python2 %:r.py && notify-send -u low "GDS is compiled"<cr>


" COMPILE ON <LEADER>CC DEPENDING ON FILE TYPE
autocmd FileType tex nnoremap <leader>cc :w<cr> :!pdflatex %:r.tex && bibtex %:r.aux && pdflatex %:r.tex && pdflatex %:r.tex && rm %:r.aux %:r.log %:r.blg %:r.bbl && notify-send -u low "LaTeX" "compilation is finished"<cr>
autocmd FileType markdown nnoremap <leader>cc :w<cr> :!pandoc %:r.md -H ~/.config/beamer/cooltemplate.tex --slide-level=2 -t beamer -o %:r.pdf<cr>
autocmd FileType python nnoremap <leader>cc :w<cr> :!python %:r.py<cr>
autocmd FileType java nnoremap <leader>cc :w<cr> :!java %:r.java<cr>


" VIEW DEPENDING ON FILE TYPE
autocmd FileType tex nnoremap <leader>cv :!zathura %:r.pdf > /dev/null 2>&1 &<cr><cr>
autocmd FileType markdown nnoremap <leader>cv :!zathura %:r.pdf > /dev/null 2>&1 &<cr><cr>
autocmd FileType python nnoremap <leader>cv :!klayout -e %:r.gds &<cr><cr>


" SPELLING AND LANGUAGE (EN + RU)
autocmd Filetype tex setlocal spell spelllang=ru_yo,en_us
autocmd Filetype mail setlocal spell spelllang=ru_yo,en_us
map <silent> <leader>- :setlocal spell spelllang=ru_yo,en_us<cr>
map <silent> <leader>_ :set nospell<cr>
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0


" RANDOM HOTKEYS
map ZQ :q!<cr>:colorscheme rem<cr>i<esc>
map ZZ :wq<cr>:colorscheme rem<cr>i<esc>
map <leader>s :%s//g<left><left>
map <leader>a :%ArrangeColumn<cr>
map <leader>A :%UnArrangeColumn<cr>
map <tab> za
nnoremap Y y$
nmap <leader>r :so $MYVIMRC<cr>
nmap <silent> <esc><esc> :noh<cr>
nmap \\ z=1<cr><cr>
imap <C-\> <Esc>[sz=1<cr>A
noremap <leader>w :up<cr>
nnoremap U <c-r>
nnoremap H ^
nnoremap L $


" TOGGLE BOOLEANS
nnoremap gt viwcTrue<esc>
nnoremap gf viwcFalse<esc>
nnoremap gT viwctrue<esc>
nnoremap gF viwcfalse<esc>


" PASTE LAST NON-DELETED
nmap <leader>p "0p
nmap <leader>P "0P


" UNDO POINTS
imap , ,<c-g>u
imap . .<c-g>u
imap ! !<c-g>u
imap ? ?<c-g>u
imap ( (<c-g>u


" KEEPING IT CENTERED
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`v


" PLUGIN MANAGER
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" filetype plugin on

call plug#begin()
" Plug 'jelera/vim-javascript-syntax'
" Plug 'SirVer/ultisnips'
" Plug 'unblevable/quick-scope'
" Plug 'chrisbra/csv.vim'
" Plug 'tpope/vim-commentary'
" Plug 'ron89/thesaurus_query.vim'
" Plug 'python-rope/ropevim'

" Python
Plug 'dense-analysis/ale'
Plug 'vim-python/python-syntax'
Plug 'tmhedberg/simpylfold'
Plug 'Chiel92/vim-autoformat'
Plug 'junegunn/vim-easy-align'
Plug 'frazrepo/vim-rainbow'
Plug 'kdheepak/lazygit.nvim'

" Latex
Plug 'anufrievroman/vim-tex-kawaii'
Plug 'anufrievroman/vim-angry-reviewer'

" Other
Plug 'ap/vim-css-color'
Plug 'tomlion/vim-solidity'
Plug 'psliwka/vim-smoothie'
Plug 'airblade/vim-gitgutter'
Plug 'junegunn/goyo.vim'
Plug 'voldikss/vim-floaterm'
Plug 'mhinz/vim-startify'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'dkarter/bullets.vim'
call plug#end()


" RAINBOW PARANTHESIS
au FileType c,python call rainbow#load()
let g:rainbow_ctermfgs = ['white', 'green', 'blue', 'red', 'magenta']


" QUICK-FIX WINDOW
nmap <silent> <c-Down>  :cnext<cr>
nmap <silent> <c-Up>  :cprev<cr>
nmap <silent> <c-Right>  :copen<cr>
nmap <silent> <c-Left>  :cclose<cr>


" SNIPPET ACTIVATION
imap <silent> <c-space> ;; <esc>hi


" WIKI
nnoremap <silent> <leader>W :e ~/Nextcloud/Notes/index.md<cr>
nnoremap <silent> <enter> gf
nnoremap <silent> <backspace> <c-o>
nnoremap <silent> <leader>x 0f]hrx
nnoremap <silent> <leader>X 0f]hr 
nnoremap <silent> <leader>t <esc>o- [ ]<esc>a 


" DETECT CSV FILES
au! BufNewFile,BufRead *.csv setf csv


" GITGUTTER SETTINGS
set updatetime=100
nmap <silent> \G :GitGutterToggle<cr>
let g:gitgutter_preview_win_floating = 0
let g:gitgutter_sign_added = '│'
let g:gitgutter_sign_modified = '│'
let g:gitgutter_sign_removed = '│'
let g:gitgutter_sign_modified_removed = '│'


" STATUSLINE
" Check this https://gabri.me/blog/diy-vim-statusline
let g:currentmode={
    \ 'n'      : 'NORMAL ',
    \ 'no'     : 'N·Operator Pending ',
    \ 'v'      : 'VISUAL ',
    \ 'V'      : 'V·Line ',
    \ '\<C-V>' : 'V·Block ',
    \ 's'      : 'Select ',
    \ 'S'      : 'S·Line ',
    \ '\<C-S>' : 'S·Block ',
    \ 'i'      : 'INSERT ',
    \ 'R'      : 'REPLACE ',
    \ 'Rv'     : 'V·Replace ',
    \ 'c'      : 'Command ',
    \ 'cv'     : 'Vim Ex ',
    \ 'ce'     : 'Ex ',
    \ 'r'      : 'Prompt ',
    \ 'rm'     : 'More ',
    \ 'r?'     : 'Confirm ',
    \ '!'      : 'Shell ',
    \ 't'      : 'Terminal '
    \}

set statusline=
set statusline+=%2*
set statusline+=%{toupper(g:currentmode[mode()])}
set statusline+=%=
" set statusline+=%l/%L
set statusline+=%f\ ·\ 
set statusline+=%{wordcount().words}\ ·
set statusline+=%3p%%

" Hide statusline in CtrP buffer
let g:ctrlp_buffer_func = {'enter': 'Function_HideStatusLine', 'exit':  'Function_ShowStatusLine', }
func! Function_HideStatusLine()
    set laststatus=0
endfunc
func! Function_ShowStatusLine()
    set laststatus=2
endfunc


" GOYO SETTINGS
map <silent> <leader>g :Goyo <bar> highlight StatusLineNC ctermfg=white<cr>:colorscheme rem<cr>

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()


" FLOATTERM
let g:floaterm_title = ''
let g:floaterm_opener = 'edit'
let g:floaterm_width = 0.3
let g:floaterm_height = 0.99
let g:floaterm_wintype = 'float'
let g:floaterm_position = 'right'
let g:floaterm_borderchars = '   │    '
let g:floaterm_autoclose = 2
map <silent> <leader><cr> :FloatermNew vifm<cr>
map <silent> <C-s> :FloatermNew<cr>
map <silent> <leader>f :FloatermNew vifm<cr>
" map <silent> <leader>f :FloatermNew fzf<cr>


" MAPPINGS FOR EASYALIGN PLUGIN
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)


" SETTINGS FOR THE TABLINE
set tabline=%!MyTabLine()
function MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    " select the highlighting
    if i + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    let buflist = tabpagebuflist(i+1)
    let winnr = tabpagewinnr(i+1)
    let label = bufname(buflist[winnr - 1]) 
    let shortlabel = fnamemodify(label, ":t") 
    let ico = WebDevIconsGetFileTypeSymbol(bufname(buflist[winnr - 1]))

    " the label is made by MyTabLabel()
    let s .= ' ' . ico . ' ' . shortlabel . ' '
  endfor
  return s
endfunction


" START PAGE SETTINGS
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   Files']            },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ ]

let g:startify_custom_header = [
  \ '  ',
  \ '   ╻ ╻   ╻   ┏┳┓',
  \ '   ┃┏┛   ┃   ┃┃┃',
  \ '   ┗┛    ╹   ╹ ╹',
  \ '   ',
  \ ]

" let g:startify_custom_header = [
  " \ '  ',
  " \ '                                                                      ',
  " \ '         ████ ██████           █████      ██                    ',
  " \ '        ███████████             █████                            ',
  " \ '        █████████ ███████████████████ ███   ███████████  ',
  " \ '       █████████  ███    █████████████ █████ ██████████████  ',
  " \ '      █████████ ██████████ █████████ █████ █████ ████ █████  ',
  " \ '    ███████████ ███    ███ █████████ █████ █████ ████ █████ ',
  " \ '   ██████  █████████████████████ ████ █████ █████ ████ ██████',
  " \ '  ',
  " \ ]
" let g:startify_custom_header = [
  " \ '  ',
  " \ '      ▐ ▄ ▄▄▄ .       ▌ ▐·▪  • ▌ ▄ ·. ',
  " \ '     •█▌▐█▀▄.▀·▪     ▪█·█▌██ ·██ ▐███▪',
  " \ '     ▐█▐▐▌▐▀▀▪▄ ▄█▀▄ ▐█▐█•▐█·▐█ ▌▐▌▐█·',
  " \ '     ██▐█▌▐█▄▄▌▐█▌.▐▌ ███ ▐█▌██ ██▌▐█▌',
  " \ '     ▀▀ █▪ ▀▀▀  ▀█▄▀▪. ▀  ▀▀▀▀▀  █▪▀▀▀',
  " \ '   ',
  " \ ]

let g:startify_enable_special      = 0
let g:startify_files_number        = 10
let g:startify_relative_path       = 1
let g:startify_change_to_dir       = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
" let g:startify_update_oldfiles     = 1
" let g:startify_padding_left = 5

let g:startify_skiplist = [
        \ '.config/nvim/vimrc.vim',
        \ ]

let g:startify_bookmarks = [
        \ { 'd': '~/Nextcloud/Notes/Database/Main.csv' },
        \ { 'a': '~/.config/alacritty/alacritty.yml' },
        \ { 'c': '~/.config/nvim/colors/rem.vim' },
        \ { 'v': '~/.config/nvim/vimrc.vim' },
        \ { 'm': '~/.config/mutt/muttrc' },
        \ { 'f': '~/.config/vifm/vifmrc' }, 
        \ { 's': '~/.bash_aliases' },
        \ { 'b': '~/.bashrc' },
        \ ]

" let g:startify_custom_footer =
"        \ ['', "   Vim is charityware. Please read ':help uganda'.", '']
nnoremap <silent>ZS :SClose<cr>


" TABS AND BUFFERS
nnoremap <silent><C-l> :tabnext<cr>
nnoremap <silent><C-h> :tabprevious<cr>
nnoremap <silent><C-t> :tabnew<cr>:Startify<cr>
nnoremap <silent><C-b> :bn<cr>
inoremap <silent><C-l> <esc>:tabnext<cr>
inoremap <silent><C-h> <esc>:tabprevious<cr>
inoremap <silent><C-t> <esc>:tabnew<cr>:Startify<cr>
nnoremap <silent><C-b> <esc>:bn<cr>


" AUTOCOMPLETE SETTINGS
set complete+=kspell
set completeopt=noselect
set shortmess+=c
inoremap <expr> <Tab> pumvisible() ? "<C-n>" : "<Tab>"
" inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" inoremap <silent> <C-P> <C-x><C-f>
" inoremap <silent> <C-N> <C-x><C-f>


" ANGRY REVIEWER SETTINGS
nnoremap <leader>ar :call AngryReviewer
let g:AngryReviewerEnglish='british'

" CtrP
nnoremap <silent> <c-space> :CtrlPMRUFiles<cr>
let g:ctrlp_line_prefix='  '

" COLORIZER
" autocmd FileType python ColorHighlight

" SETTINGS FOR SOLIDITY AND JAVASCRIPT
autocmd Filetype javascript setlocal ts=2 sw=2 expandtab
autocmd Filetype solidity setlocal ts=2 sw=2 expandtab


" PYTHON SETTING

" SIMPLYFOLDING OF PYTHON CODE
let g:SimpylFold_fold_blank = 1
autocmd FileType python set foldlevel=99

set foldmethod=marker
set foldmarker=<<<,>>>
function! MyFoldPython()
    let line = getline(v:foldstart)
    let folded_line_num = v:foldend - v:foldstart
    let line_text = substitute(line, '^%<\+', '', 'g')
    return '‣'.  line_text   
endfunction
autocmd FileType python set foldtext=MyFoldPython()
set fillchars=fold:\ 

" PYTHON SYNTAX HIGHLIGHT
let g:python_highlight_all = 1


" AUTOFORMAT
" Install pip install --user yapf
let g:formatter_yapf_style = 'pep8'
noremap <leader>fa :Autoformat<CR>
noremap <leader>fl :AutoformatLine<CR>
noremap <leader>f<space> :RemoveTrailingSpaces<CR>


" ALE
let g:ale_linters = {'python': ['pylint'], 'javascript': ['eslint']}
" let g:ale_linters = {'python': ['flake8', 'pylint'], 'javascript': ['eslint']}
let g:ale_fixers = {'python': ['yapf']}

nmap <leader>af :ALEFix<CR>
let g:ale_fix_on_save = 0
let g:ale_sign_error = ''
let g:ale_sign_warning = '' 
let g:ale_set_highlights = 0
let g:ale_echo_msg_format = '%s'


" CUSTOM HIGHLIGHTS
autocmd FileType python syn match myPyDecorators '@property'
autocmd FileType python syn match myPyDecorators '@staticmethod'
autocmd FileType python syn match myPyDecorators '@classmethod'

autocmd FileType csv syntax match myCsvHeading /\%1l\%(\%("\zs\%([^"]\|""\)*\ze"\)\|\%(\zs[^,"]*\ze\)\)/
autocmd FileType csv syntax match myCsvComma ','

autocmd FileType markdown syn match myFilesMd '\S*\.md'
autocmd FileType markdown syn match myFilesCsv '\S*\.csv'
autocmd FileType markdown syn match myFilesTxt '\S*\.txt'
autocmd FileType markdown syn match myCheckboxOK '-\ \[x\]'
autocmd FileType markdown syn match myCheckbox '-\ \[\ ]'
autocmd FileType markdown syn match myCheckbox '[^-]*-\ \[\ ]'
autocmd FileType markdown syn match myCheckbox '[^-]*-\ \[x\]'

" CUSTOM CONCEALS
autocmd FileType python syntax match pyNiceOperator "\<in\>" conceal cchar=∈
autocmd FileType python syntax match pyNiceOperator "\<not in\>" conceal cchar=∉
autocmd FileType python syntax match pyNiceOperator "<=" conceal cchar=≤
autocmd FileType python syntax match pyNiceOperator ">=" conceal cchar=≥
autocmd FileType python syntax match pyNiceOperator "\\alpha" conceal cchar=α
autocmd FileType python syntax match pyNiceOperator "=\@<!===\@!" conceal cchar=≡

