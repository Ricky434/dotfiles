return {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    enabled = true,
    priority = 1000,
    config = function()
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
                ModeMsg = { fg = '$fg' },
                FoldColumn = {fg = '$light_grey', bg = '$transparent' and '$none' or '$bg'},
                TroubleNormal = { bg = '$bg0' },
                TroubleNormalNC = { bg = '$bg0' },
            },
        }
        require('onedark').load()
    end,
}
