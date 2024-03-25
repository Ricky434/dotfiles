return {
  'lervag/vimtex',
  version = '^3', -- Recommended
  ft = { 'tex', 'plaintex' },
  config = function ()
    vim.g.vimtex_view_method = 'general'
    vim.g.maplocalleader = '\\'
  end
}
