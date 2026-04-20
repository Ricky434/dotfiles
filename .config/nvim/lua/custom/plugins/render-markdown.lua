return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
    config = function()
      require('render-markdown').setup({
        completions = { lsp = { enabled = true } },
        strikethrough = {
          enabled = false,
        },
      })

      vim.api.nvim_set_hl(0, "@markup.strikethrough", { link = "Normal" })
      
      vim.keymap.set("n", "<leader>ra",  "a$\\rightarrow$<Esc>f$l", { desc = "right arrow" })
    end
  },
  {
    'vim-pandoc/vim-pandoc-syntax'
  }
}
