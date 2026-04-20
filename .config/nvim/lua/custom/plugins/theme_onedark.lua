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
                ["@keyword.conditional"] = { fg = '$red' },
                ["@keyword.repeat"] = { fg = '$red' },
                ["@keyword.coroutine"] = { fg = '$red' },
                ["@keyword.return"] = { fg = '$red' },
                ["@keyword.type"] = { fg = '$red' },
                ["@keyword"] = { fg = '$red' },
                IblScope = { fg = '$grey' },
                ModeMsg = { fg = '$fg' },
                FoldColumn = {fg = '$light_grey', bg = '$transparent' and '$none' or '$bg'},
                TroubleNormal = { bg = '$bg0' },
                TroubleNormalNC = { bg = '$bg0' },
                OilGitAdded = { fg = "$cyan" },
                OilGitModified = { fg = "$yellow" },
                OilGitRenamed = { fg = "$red" },
                OilGitUntracked = { fg = "$green" },
                OilGitIgnored = { fg = "$grey" },
            },
        }
        require('onedark').load()
    end,
}
