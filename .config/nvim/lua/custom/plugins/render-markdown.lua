return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim', -- if you use the mini.nvim suite
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
      -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    ft = { "markdown" },
    config = function()
      if vim.bo.buftype == "nofile" then -- don't load it for lsp docs
        return
      end

      require('render-markdown').setup({
        completions = { lsp = { enabled = true } }, -- for checkboxes and callouts
        heading = {
          enabled = false,
        },
        bullet = {
          enabled = false,
        },
      })

      -- marksman lsp molto utile
      -- crea .marksman.toml in folder di lavoro per permettere suggestion lsp relativi a file in quella folder

      vim.api.nvim_set_hl(0, "@markup.strikethrough", { link = "Normal" })

      local c = require('onedark.colors')
      vim.api.nvim_set_hl(0, "RenderMarkdownBullet", { fg = c.red })

      vim.keymap.set("n", "<leader>ra", "a$\\rightarrow$<Esc>f$l", { desc = "right arrow" })

      -- vim.opt.spelllang = 'it'
      -- vim.opt.spell = true
      -- zg to mark word as correct
      -- z= to fix word
    end
  },
}
