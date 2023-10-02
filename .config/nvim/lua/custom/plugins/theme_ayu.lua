return {
  'Shatur/neovim-ayu',
  enabled = true,
  priority = 1000,
  config = function()
    require('ayu').setup({
      mirage = true,
      overrides = {},
    })
    vim.cmd.colorscheme 'ayu'
  end,
}
