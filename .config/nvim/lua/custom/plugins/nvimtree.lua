-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    enabled = true,
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            hijack_netrw = false,
            renderer = {
                indent_markers = {
                    enable = true,
                },
                group_empty = true,
                icons = {
                    show = {
                        modified = true,
                        folder_arrow = false,
                    },
                    glyphs = {
                        modified = '•',
                    }
                },
                --highlight_modified = "name",
            },
            filters = {
                dotfiles = true,
            },
            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
                debounce_delay = 50,
                icons = {
                    error = '', --
                    warning = '',
                    info = '',
                    hint = '',
                },
            },
            modified = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = false,
            },
        })

        vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
        vim.keymap.set("v", "<leader>e", vim.cmd.NvimTreeToggle)

        -- Open nvim-tree automatically for directories and change neovim's directory
        local function open_nvim_tree(data)
            local directory = vim.fn.isdirectory(data.file) == 1

            if not directory then
                return
            end

            vim.cmd.cd(data.file)

            require("nvim-tree.api").tree.open({ current_window = true })
        end
        vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
        ---
    end
}
