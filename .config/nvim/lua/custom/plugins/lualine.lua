return {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
        options = {
            icons_enabled = false,
            theme = 'auto',
            component_separators = '|',
            section_separators = '',
        },
        sections = {
            lualine_c = {
                'filename',
                function()
                    return require('auto-session.lib').current_session_name(true)
                end
            },
        },
    },
}
