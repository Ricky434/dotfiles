return {
  'vimwiki/vimwiki',
  init = function ()
    vim.g.vimwiki_ext2syntax = {
        [".wiki"] = "default",
        [".txt"] = "default",
    }

    vim.g.vimwiki_list = {
      {
        name = "Default wiki",
        path = "~/Random/vimwiki/",
        path_html = "~/Random/vimwiki/html/",
        syntax = "default",
        nested_syntaxes = { python = "python", c = "c" },
        ext = ".wiki",
        auto_export = 0,
        auto_toc = 0,
        -- other, see vimwiki-option
      },
    }
  end,
  config = function ()
    vim.keymap.del("n", "<Leader>ws")
    vim.keymap.set("n", "<Leader>w<Leader>s", "<Plug>VimwikiUISelect", { remap = true, desc = "List and select available wikis" })

    -- wc colorize ~meh
    -- wd delete current file ~meh
    -- wn goto (or create new) ~ok
    -- wr rename ~meh
    -- wh build html ~ok
    -- whh open html ~meh
    -- wi diary index ~useless
    -- ww, wt index, index in new tab ~ok
    -- w_ tutti per il diario (tranne w_s rimappato da me) ~meh
    --
    -- <CR> follow/create link
    -- <S-CR> split and follow/create link
    -- <C-CR> vsplit and follow/create link
    -- <C-S-CR> tab and follow/create link
    -- <backspace> go back to previous page
    -- <tab> find next link in page
    -- <S-tab> find prev link in page
    -- = add header level (on existing words)
    -- - remove header level
    -- ]] goto next header
    -- [[ goto prev header
    -- other goto headers
    -- + decorate link (add placeholder description
    -- <C-space> toggle checkbox in list item
    -- too many..
    --    gln glp increase/decrease checkbox completion
    --    gll glh increase list level
    --    ... just look at the help for everything, syntax as well

    local c = require('onedark.colors')
    vim.api.nvim_set_hl(0, "VimwikiHeader1", { fg = c.red })
    vim.api.nvim_set_hl(0, "VimwikiHeader2", { fg = c.blue })
    vim.api.nvim_set_hl(0, "VimwikiHeader3", { fg = c.yellow })
    vim.api.nvim_set_hl(0, "VimwikiHeader4", { fg = c.purple })
    vim.api.nvim_set_hl(0, "VimwikiHeader5", { fg = c.cyan })
  end
}
