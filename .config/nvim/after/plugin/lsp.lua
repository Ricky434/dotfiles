local lsp = require('lsp-zero').preset("recommended")

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

require "lsp_signature".setup(cfg)

local cmp = require('cmp')
local cmp_action = require('lsp-zero').cmp_action()

lsp.setup_nvim_cmp({
  mapping = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-r>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp_action.luasnip_supertab(),
    ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
  })
})


lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
  vim.keymap.set("n", "gl", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', {buffer = true}) -- remap to use telescope
  vim.keymap.set("n", "<leader>vws", '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', {buffer = true}) -- remap to use telescope
end)

lsp.format_on_save({
    servers = {
        ['gopls'] = {'go'},
    }
})

lsp.configure('html', {
    filetypes = { "html", "template" }
})

lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
