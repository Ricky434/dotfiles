return {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    enabled = true,
    priority = 1000,
    config = function()
        vim.cmd.colorscheme 'onedark'
        require('onedark').setup {
            style = 'darker',
            ending_tildes = true, -- Show the end-of-buffer tildes. By default they are hidden
            colors = {
                red = '#e06c75',
            },
            highlights = {
                ["@conditional"] = { fg = '$red' },
                ["@repeat"] = { fg = '$red' },
                ["@keyword"] = { fg = '$red' },
                ["@punctuation.bracket"] = { fg = '#abb2bf' },
            },
        }
        require('onedark').load()
    end,
}
