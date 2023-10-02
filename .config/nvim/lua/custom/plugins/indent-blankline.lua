return {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    config = function()
        require('ibl').setup {
            indent = {
                char = '┊',
            },
            whitespace = {
                remove_blankline_trail = true,
            },
            scope = {
                show_start = false,
            },
        }
    end,
}
