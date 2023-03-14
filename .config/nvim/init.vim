syntax on
set autoindent
"set mouse=
set relativenumber
set number
set ignorecase
set smartcase " smartcase needs ignore set)
set termguicolors
set undofile " make undo history persist after closing files

" ---- Per copia incolla
" - y copia nel registro "" (default) e "0 di nvim
" - "+y copia nel registro "+ di nvim, che corrisponde alla clipboard di X11, e
" 	nel registro di default
" - "*y copia nel registro "* di nvim, che corrisponde alla selezione di X11
" 	(quella che si incolla con il middle mouse), e nel registro di default
"
" Lo stesso vale per p
" Se si copia e incolla con il right mouse (l'opzione mouse deve essere
" 	attiva) viene usato il registro "*
" ---- 

" Remappa a Esc il tasto per uscire da Terminal mode (invece di Ctrl+\+Ctrl+n)
tnoremap <Esc> <C-\><C-n>

" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(stdpath('data').'/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/ojroques/nvim-hardline
" Plug 'ojroques/nvim-hardline'
Plug 'vim-airline/vim-airline'
Plug 'sainnhe/gruvbox-material'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'norcalli/nvim-colorizer.lua'

" Initialize plugin system
call plug#end()


" ---- GRUVBOX-MATERIAL OPTIONS
" Important!!
if has('termguicolors')
	set termguicolors
endif
" For dark version.
set background=dark
" For light version.
" set background=light
" Set contrast.
" This configuration option should be placed before `colorscheme gruvbox-material`.
" Available values: 'hard', 'medium'(default), 'soft'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_disable_italic_comment = 0
let g:gruvbox_material_enable_bold = 1
" Ci sono molte piu' cose da configurare se vuoi (vedi la pagina github di gruvbox material)
colorscheme gruvbox-material
let g:airline_theme = 'gruvbox_material'
" ----------

" ---- GRUVBOX OPTIONS
let g:gruvbox_italic = 1
let g:gruvbox_contrast_dark = 'medium'

""colorscheme gruvbox
""let g:airline_theme = 'gruvbox'


" ---- COLORIZER
lua require'colorizer'.setup()
