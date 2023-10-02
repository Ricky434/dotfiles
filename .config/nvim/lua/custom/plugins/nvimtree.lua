-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

return {
    'nvim-tree/nvim-tree.lua',
    config = function()
        require("nvim-tree").setup({
            sort_by = "case_sensitive",
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = true,
            },
        })

        vim.keymap.set("n", "<leader>e", vim.cmd.NvimTreeToggle)
        vim.keymap.set("v", "<leader>e", vim.cmd.NvimTreeToggle)
    end
}
