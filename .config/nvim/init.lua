-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- Install lazy nvim package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable', -- latest stable release
        lazypath,
    }
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- Install plugins
require('lazy').setup({
    -- Git related plugins
    'tpope/vim-fugitive',
    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',
    -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim',  opts = {} },
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'custom.plugins' },
}, {})

require("keymaps")
require("settings")
require("custom.other-configs")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- Diagnostic keymaps
vim.diagnostic.config({ float = { border = "rounded" } })
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- [[ Configure LSP ]]
-- Configure lsp borders
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
    -- Function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>gt', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', '[G]oto definition in new [T]ab')
    nmap('<leader>gr', vim.lsp.buf.references, '[G]oto [R]eferences (No Telescope)')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
local servers = {
    -- clangd = {},
    -- gopls = {},
    -- pyright = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    html = { filetypes = { 'html', 'template', 'twig', 'hbs' } },

    lua_ls = {
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        }
    },

    pylsp = {
        settings = {
            pylsp = {
                plugins = {
                    pylint = { args = { '--ignore=E501,E231', '-' }, enabled = false, debounce = 200 },
                    pycodestyle = {
                        enabled = false,
                        ignore = { 'E501', 'E231' },
                        maxLineLength = 120
                    },
                }
            }
        }
    },
}
vim.lsp.set_log_level('warn')

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),

    -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
    -- This setting has no relation with the `ensure_installed` setting.
    -- Can either be:
    --   - false: Servers are not automatically installed.
    --   - true: All servers set up via lspconfig are automatically installed.
    --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
    --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
    ---@type boolean
    automatic_installation = false,
}

mason_lspconfig.setup_handlers {
    function(server_name)
        require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
                on_attach(client, bufnr)
                if servers[server_name] ~= nil and servers[server_name].on_attach then
                    servers[server_name].on_attach(client, bufnr)
                end
            end,
            settings = (servers[server_name] or {}).settings,
            filetypes = (servers[server_name] or {}).filetypes,
            handlers = handlers,
        }
    end
}

-- Set same keybinds for haskell-tools
vim.g.haskell_tools = {
    hls = {
        on_attach = on_attach
    }
}
