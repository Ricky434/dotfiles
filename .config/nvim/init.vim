syntax on
set autoindent

" Ignore case unless use a capital in search (smartcase needs ignore set)
set ignorecase
set smartcase


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
