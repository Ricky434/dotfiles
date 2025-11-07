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
    'tpope/vim-obsession',
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

-- Diagnostic config
vim.diagnostic.config({
    float = { border = "rounded" },
    jump = { float = true },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = '', --
            [vim.diagnostic.severity.WARN] = '',
            [vim.diagnostic.severity.INFO] = '',
            [vim.diagnostic.severity.HINT] = '',
        },
    },
    -- TODO: highlight colors
    virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
            local diagnostic_message = {
                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                [vim.diagnostic.severity.WARN] = diagnostic.message,
                [vim.diagnostic.severity.INFO] = diagnostic.message,
                [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
        end,
    },
})

-- [d = goto_prev diagnostic
-- ]d = goto_next diagnostic
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })


-- [[ Configure LSP ]]
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

    local tbuiltin = require('telescope.builtin')
    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('<leader>gt', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', '[G]oto definition in new [T]ab')
    nmap('<leader>gr', vim.lsp.buf.references, '[G]oto [R]eferences (No Telescope)')
    nmap('gr', tbuiltin.lsp_references, '[G]oto [R]eferences')
    nmap('gi', tbuiltin.lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', tbuiltin.lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', tbuiltin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- already defined by default by nvim
    -- have to redefine it to have it with borders
    -- handlers set up in lsp config don't work anymore 
    -- (they work only for server->client requests, but hover is client->server)
    -- setting vim.o.winborder breaks telescope
    nmap('K', function() vim.lsp.buf.hover({border="rounded"}) end, 'Hover Documentation')
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
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_enable = false,
    automatic_installation = false,
}

-- Setup servers
for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
    local config = {
        capabilities = capabilities,
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            if servers[server_name] ~= nil and servers[server_name].on_attach then
                servers[server_name].on_attach(client, bufnr)
            end
        end,
        settings = (servers[server_name] or {}).settings,
        filetypes = (servers[server_name] or {}).filetypes,
    }

    vim.lsp.config(server_name, config)
    vim.lsp.enable(server_name)
end

-- Set same keybinds for haskell-tools
vim.g.haskell_tools = {
    hls = {
        on_attach = on_attach
    }
}


-- Automatically change neovim's directory when opening a directory
local function change_dir(data)
    -- remove the "oil://" prefix if present (generated by oil nvim)
    local file_trimmed = data.file:gsub('^'.."oil://","")
    print(file_trimmed)

    local directory = vim.fn.isdirectory(file_trimmed) == 1

    if not directory then
        return
    end

    vim.cmd.cd(file_trimmed)

end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = change_dir })
