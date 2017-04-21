syntax on
set tabstop=2
set expandtab
set shiftwidth=2
set hidden
retab
set number
set hlsearch
set statusline=%t[%{strlen(&fenc)?&fenc:'none'},%{&ff}]%h%m%r%y%=%c,%l/%L\ %P
set laststatus=2
set noswapfile
vmap <C-c> "+y
nnoremap <C-j> :bprevious<CR>
nnoremap <C-k> :bnext<CR>

" Vundle
set nocompatible
filetype off

call plug#begin('~/.local/share/nvim/plugged')
Plug 'vim-scripts/Vimball'
Plug 'vim-scripts/tComment'
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-endwise'
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
Plug 'hwartig/vim-seeing-is-believing'
Plug 'tomtom/tlib_vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'garbas/vim-snipmate'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'kchmck/vim-coffee-script'
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'maksimr/vim-jsbeautify'
Plug 'kien/ctrlp.vim'
Plug 'slim-template/vim-slim'
Plug 'danro/rename.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'AndrewRadev/vim-eco'
Plug 'alvan/vim-closetag'
Plug 'elixir-lang/vim-elixir'
Plug 'isRuslan/vim-es6'
Plug 'mxw/vim-jsx'
Plug 'othree/yajs.vim'
Plug 'henrik/vim-qargs'
call plug#end()
filetype plugin indent on

set t_Co=256

" fonts airline config
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" closetag
let g:closetag_filenames = "*.html,*.haml,*.hamlc,*.jst,*.jst.eco,*.slim"

" vimdiff configs
:set diffopt+=vertical
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red
highlight Search     cterm=NONE ctermfg=10 ctermbg=17

" seeing-is-believing
nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
xmap <buffer> <F5> <Plug>(seeing-is-believing-run)
imap <buffer> <F5> <Plug>(seeing-is-believing-run)

nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
imap <buffer> <F4> <Plug>(seeing-is-believing-mark)

" jsbeautify
nmap <C-e> :call JsBeautify()<cr>

" CTags
nmap <silent> <C-L> :ta <C-R><C-W><cr>
nmap <silent> <C-G> :!ctags -R . $(bundle list --paths)<cr>

" No highlight
nmap <silent> <C-I> :noh<cr>


set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
let mapleader=' '

" vim-rspec
map <Leader>s :call RunCurrentSpecFile()()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>

nmap <leader>jt <Esc>:%!json_xs -f json -t json-pretty<CR>

" config for https://github.com/jistr/vim-nerdtree-tabs
nmap <leader>h <Esc>:NERDTreeTabsToggle<CR>

" linter config 
let g:ale_linters = {
\   'javascript': ['eslint'],
\}

autocmd QuickFixCmdPost *grep* cwindow
au BufRead,BufNewFile *.hamlc set filetype=haml
au BufRead,BufNewFile *.rabl set filetype=ruby
highlight DiffAdd    cterm=bold ctermfg=15 ctermbg=22 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=15 ctermbg=88 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=15 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=15 ctermbg=8 gui=none guifg=bg guibg=Red

" Return indent (all whitespace at start of a line), converted from
" tabs to spaces if what = 1, or from spaces to tabs otherwise.
" When converting to tabs, result has no redundant spaces.
function! Indenting(indent, what, cols)
	let spccol = repeat(' ', a:cols)
	let result = substitute(a:indent, spccol, '\t', 'g')
	let result = substitute(result, ' \+\ze\t', '', 'g')
	if a:what == 1
		let result = substitute(result, '\t', spccol, 'g')
	endif
	return result
endfunction

" Convert whitespace used for indenting (before first non-whitespace).
" what = 0 (convert spaces to tabs), or 1 (convert tabs to spaces).
" cols = string with number of columns per tab, or empty to use 'tabstop'.
" The cursor position is restored, but the cursor will be in a different
" column when the number of characters in the indent of the line is changed.
function! IndentConvert(line1, line2, what, cols)
	let savepos = getpos('.')
	let cols = empty(a:cols) ? &tabstop : a:cols
	execute a:line1 . ',' . a:line2 . 's/^\s\+/\=Indenting(submatch(0), a:what, cols)/e'
	call histdel('search', -1)
	call setpos('.', savepos)
endfunction
command! -nargs=? -range=% Space2Tab call IndentConvert(<line1>,<line2>,0,<q-args>)
command! -nargs=? -range=% Tab2Space call IndentConvert(<line1>,<line2>,1,<q-args>)
command! -nargs=? -range=% RetabIndent call IndentConvert(<line1>,<line2>,&et,<q-args>)"
