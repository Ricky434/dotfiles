Updated to nvim config in commit b0e46b58b11a740984cf633e6786d9b79c4de4c9 of dotfiles

# Custom
v  <Space>     <Nop>                     (disable space to use it as leader)
n  <Space>     <Nop>                     (disable space to use it as leader)
n  <Space>Y    "+Y                       (yank line to clipboard)
v  <Space>y    "+y                       (yank to clipboard)
n  <Space>y    "+y                       (yank to clipboard)
x  <Space>p    "_dP                      (paste from clipboard)
v  J           :m '>+1<CR>gv=gv          (move selected text down)
v  K           :m '<-2<CR>gv=gv          (move selected text up)
n  <C-U>       <C-U>zz                   (keep cursor centered)
n  <C-D>       <C-D>zz                   (keep cursor centered)
n  n           nzzzv                     (keep cursor centered)
n  N           Nzzzv                     (keep cursor centered)
n  j           v:count == 0 ? 'gj' : 'j' (deal with word wrap)
n  k           v:count == 0 ? 'gk' : 'k' (deal with word wrap)
n  XX          :w<CR>                    (save)

# Autopairs
i  <BS>        (delete both brackets)
i  <M-e>       fastwrap
i  <Space>     autopairs map key (space brackets)
i  "           autopairs map key
i  '           autopairs map key
i  (           autopairs map key
i  )           autopairs map key
i  `[`           autopairs map key
i  `]`           autopairs map key
i  `           autopairs map key
i  {           autopairs map key
i  }           autopairs map key

# Telescope
n  <Space>fr   [F]ind [R]esume
n  <Space>fd   [F]ind [D]iagnostics
n  <Space>fg   [F]find by [G]rep
n  <Space>fw   [F]ind current [W]ord
n  <Space>fh   [F]ind [H]elp
n  <Space>ff   [F]ind [F]iles
n  <Space>gf   Search [G]it [F]iles
n  <Space>gs   Search [G]it [S]tatus
n  <Space>/    [/] Fuzzily search in current buffer
n  <Space><Space> [" "] Find existing buffers
n  <Space>?    [?] Find recently opened files
n  <Space>ws   LSP: [W]orkspace [S]ymbols
n  <Space>ds   LSP: [D]ocument [S]ymbols
n  gi          LSP: [G]oto [I]mplementation
n  gr          LSP: [G]oto [R]eferences
## Others in config
?  <C-T>       Open with trouble
?  <M-T>       Add to trouble

# Lsp
n  <Space>wl   LSP: [W]orkspace [L]ist Folders
n  <Space>D    LSP: Type [D]efinition
n  <Space>gr   LSP: [G]oto [R]eferences (No Telescope)
n  <Space>ca   LSP: [C]ode [A]ction
n  <Space>rn   LSP: [R]e[n]ame
n  K           LSP: Hover Documentation

# Gitsigns
n  <Space>ggr  Reset git hunk
n  <Space>ggu  Unstage git hunk
n  <Space>gga  Stage git hunk
n  <Space>gl   Toggle line change highlight
n  <Space>gd   Use nvim diff for current file
n  <Space>gb   Blame line
n  <Space>gp   Preview git hunk
v  `[c`          Jump to previous hunk
n  `[c`          Jump to previous hunk
v  `]c`          Jump to next hunk
n  ]c          Jump to next hunk
n  gD          LSP: [G]oto [D]eclaration
n  gd          LSP: [G]oto [D]efinition
n  <C-K>       LSP: Signature Documentation

# Treesitter
n  <Space>A    Swap previous @parameter.inner
n  <Space>a    Swap next @parameter.inner
o  [M          Goto previous end @function.outer
x  [M          Goto previous end @function.outer
n  [M          Goto previous end @function.outer
o  []          Goto previous end @class.outer
x  []          Goto previous end @class.outer
n  []          Goto previous end @class.outer
o  `[m`          Goto previous start @function.outer
x  `[m`          Goto previous start @function.outer
n  `[m`          Goto previous start @function.outer
o  `[[`          Goto previous start @class.outer
x  `[[`          Goto previous start @class.outer
n  `[[`          Goto previous start @class.outer
o  `]M`          Goto next end @function.outer
x  `]M`          Goto next end @function.outer
n  `]M`          Goto next end @function.outer
o  `][`          Goto next end @class.outer
x  `][`          Goto next end @class.outer
n  `][`          Goto next end @class.outer
o  `]m`          Goto next start @function.outer
x  ]m          Goto next start @function.outer
n  ]m          Goto next start @function.outer
o  ]]          Goto next start @class.outer
x  ]]          Goto next start @class.outer
n  ]]          Goto next start @class.outer
x  ac          Select textobject @class.outer
o  ac          Select textobject @class.outer
x  af          Select textobject @function.outer
o  af          Select textobject @function.outer
x  aa          Select textobject @parameter.outer
o  aa          Select textobject @parameter.outer
x  if          Select textobject @function.inner
o  if          Select textobject @function.inner
x  ic          Select textobject @class.inner
o  ic          Select textobject @class.inner
x  ia          Select textobject @parameter.inner
o  ia          Select textobject @parameter.inner
n  <C-Space>   Start selecting nodes with nvim-treesitter
x  <M-Space>   Shrink selection to previous named node
x  <C-S>       Increment selection to surrounding scope
x  <C-Space>   Increment selection to named node

# Harpoon
n  <Space>i    Go to next in harpoon list
n  <Space>o    Go to prev in harpoon list
n  <Space>h    Add file to harpoon
n  <C-E>       Open quick menu
n  <C-H>       Go to file 1
n  <C-J>       Go to file 2
n  <C-N>       Go to file 3

# Trouble
n  <Space>cs   Symbols (Trouble)
n  <Space>xX   Buffer Diagnostics (Trouble)
n  <Space>xx   Diagnostics (Trouble)
n  <Space>xQ   Quickfix List (Trouble)
n  <Space>xL   Location List (Trouble)
n  <Space>cl   LSP Definitions / references / ... (Trouble)

# Mini
o  al            Around last textobject
o  an            Around next textobject
x  al            Around last textobject
x  an            Around next textobject
o  a             Around textobject
x  a             Around textobject
o  g]            Move to right "around"
x  g]            Move to right "around"
n  g]            Move to right "around"
o  g[            Move to left "around"
x  g[            Move to left "around"
n  g[            Move to left "around"
o  il            Inside last textobject
o  in            Inside next textobject
x  il            Inside last textobject
x  in            Inside next textobject
o  i             Inside textobject
x  i             Inside textobject
n  shn         Highlight next surrounding
n  sFn         Find next left surrounding
n  sfn         Find next right surrounding
n  srn         Replace next surrounding
n  sdn         Delete next surrounding
n  shl         Highlight previous surrounding
n  sFl         Find previous left surrounding
n  sfl         Find previous right surrounding
n  srl         Replace previous surrounding
n  sdl         Delete previous surrounding
x  sa          Add surrounding to selection
n  sn          Update `MiniSurround.config.n_lines`
n  sh          Highlight surrounding
n  sF          Find left surrounding
n  sf          Find right surrounding
n  sr          Replace surrounding
n  sd          Delete surrounding
n  sa          Add surrounding

# Comment
n  gcA         Comment insert end of line
n  gcO         Comment insert above
n  gco         Comment insert below
n  gbc         Comment toggle current block
o  gc          Comment textobject
n  gcc         Comment toggle current line

# Diagnostics
n  <Space>q    Open diagnostics list
n  `[d`          Go to previous diagnostic message
n  ]d          Go to next diagnostic message
n  gl          Open floating diagnostic message
g  <C-W><C-D>  <C-W>d
n  <C-W>d      Show diagnostics under the cursor

# Neorg
[todo] (defaults)

# Cmp
s  <Tab>       cmp.utils.keymap.set_map (smart? tab)
i  <Tab>       cmp.utils.keymap.set_map (smart? tab)
s  <CR>        cmp.utils.keymap.set_map (confirm selection or CR)
i  <CR>        cmp.utils.keymap.set_map (confirm selection or CR)
s  <S-Tab>     cmp.utils.keymap.set_map (smart? S-tab)
i  <S-Tab>     cmp.utils.keymap.set_map (smart? S-tab)
i  <C-Y>       cmp.utils.keymap.set_map (confirm selection)
i  <C-Space>   cmp.utils.keymap.set_map (open complete menu)
i  <C-E>       cmp.utils.keymap.set_map (?)
i  <Down>      cmp.utils.keymap.set_map (select next item)
i  <C-D>       cmp.utils.keymap.set_map (scroll docs down?)
i  <C-F>       cmp.utils.keymap.set_map (scroll docs up?)
i  <C-R>       cmp.utils.keymap.set_map (abort)
i  <C-N>       cmp.utils.keymap.set_map (select next item)
i  <Up>        cmp.utils.keymap.set_map (select next item)
i  <C-P>       cmp.utils.keymap.set_map (select previous item)

# Haskell-tools
[todo] (defaults)

# Nvimtree
v  <Space>e    * <Lua 70: vim/_editor.lua:0> (open nvimtree i think)
n  <Space>e    * <Lua 25: vim/_editor.lua:0> (open nvimtree i think)
n  <Tab>       nvim-tree: Open Preview
n  <CR>        nvim-tree: Open
n  -           nvim-tree: Up
n  .           nvim-tree: Run Command
n  <           nvim-tree: Previous Sibling
n  >           nvim-tree: Next Sibling
n  B           nvim-tree: Toggle Filter: No Buffer
n  C           nvim-tree: Toggle Filter: Git Clean
n  D           nvim-tree: Trash
n  E           nvim-tree: Expand All
n  F           nvim-tree: Live Filter: Clear
n  H           nvim-tree: Toggle Filter: Dotfiles
n  I           nvim-tree: Toggle Filter: Git Ignore
n  J           nvim-tree: Last Sibling
n  K           nvim-tree: First Sibling
n  L           nvim-tree: Toggle Group Empty
n  M           nvim-tree: Toggle Filter: No Bookmark
n  O           nvim-tree: Open: No Window Picker
n  P           nvim-tree: Parent Directory
n  R           nvim-tree: Refresh
n  S           nvim-tree: Search
n  U           nvim-tree: Toggle Filter: Hidden
n  W           nvim-tree: Collapse
n  Y           nvim-tree: Copy Relative Path
n  `[e`          nvim-tree: Prev Diagnostic
n  `[c`          nvim-tree: Prev Git
n  `]e`          nvim-tree: Next Diagnostic
n  ]c          nvim-tree: Next Git
n  a           nvim-tree: Create File Or Directory
n  bmv         nvim-tree: Move Bookmarked
n  bt          nvim-tree: Trash Bookmarked
n  bd          nvim-tree: Delete Bookmarked
n  c           nvim-tree: Copy
n  d           nvim-tree: Delete
n  e           nvim-tree: Rename: Basename
n  f           nvim-tree: Live Filter: Start
n  ge          nvim-tree: Copy Basename
n  gy          nvim-tree: Copy Absolute Path
n  g?          nvim-tree: Help
n  m           nvim-tree: Toggle Bookmark
n  o           nvim-tree: Open
n  p           nvim-tree: Paste
n  q           nvim-tree: Close
n  r           nvim-tree: Rename
n  s           nvim-tree: Run System
n  u           nvim-tree: Rename: Full Path
n  x           nvim-tree: Cut
n  y           nvim-tree: Copy Name
n  <2-RightMouse> nvim-tree: CD
n  <2-LeftMouse> nvim-tree: Open
n  <BS>        nvim-tree: Close Directory
n  <C-X>       nvim-tree: Open: Horizontal Split
n  <C-V>       nvim-tree: Open: Vertical Split
n  <C-T>       nvim-tree: Open: New Tab
n  <C-R>       nvim-tree: Rename: Omit Filename
n  <C-K>       nvim-tree: Info
n  <C-E>       nvim-tree: Open: In Place
n  <C-]>       nvim-tree: CD

# TodoComments
[todo] (defaults)

# Undotree
n  <Space>u    * <Lua 264: vim/_editor.lua:0> (open undotree i think)
n  <Tab>        @<Plug>UndotreeFocusTarget
n  <CR>         @<Plug>UndotreeEnter
n  <            @<Plug>UndotreePreviousSavedState
n  >            @<Plug>UndotreeNextSavedState
n  ?            @<Plug>UndotreeHelp
n  C            @<Plug>UndotreeClearHistory
n  D            @<Plug>UndotreeDiffToggle
n  J            @<Plug>UndotreePreviousState
n  K            @<Plug>UndotreeNextState
n  T            @<Plug>UndotreeTimestampToggle
n  q            @<Plug>UndotreeClose
n  u            @<Plug>UndotreeUndo
n  <2-LeftMouse>  @<Plug>UndotreeEnter
n  <C-R>        @<Plug>UndotreeRedo

# Vimtex
[todo] (defaults)

# Misc
x  #           :help v_#-default
n  &           :help &-default
x  *           :help v_star-default
x  @           :help v_@-default
x  Q           :help v_Q-default
n  Y           :help Y-default
x  gx          Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)
n  gx          Opens filepath or URI under cursor with the system handler (file explorer, web browser, …)
n  y<C-G>      & :<C-U>call setreg(v:register, fugitive#Object(@%))<CR>
n  <C-L>       :help CTRL-L-default
i  <C-W>       * <C-G>u<C-W>
                 :help i_CTRL-W-default
i  <C-U>       * <C-G>u<C-U>
                 :help i_CTRL-U-default

---
Keybinds with <Plug> can be ignored, those are internal to plugins

vmap = visual and select
xmap = only visual
omap = operator pending (?)

---
