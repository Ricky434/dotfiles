return {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
        -- See `:help gitsigns.txt`
        signs = {
            add = { text = '┆' },
            change = { text = '┆' },
            delete = { text = '┆' },
            topdelete = { text = '┆' },
            changedelete = { text = '┆' },
        },
        on_attach = function(bufnr)
            vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk,
                { buffer = bufnr, desc = 'Preview git hunk' })
            vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line,
                { buffer = bufnr, desc = 'Blame line' })
            vim.keymap.set('n', '<leader>gd', require('gitsigns').diffthis,
                { buffer = bufnr, desc = 'Use nvim diff for current file' })
            vim.keymap.set('n', '<leader>gl', require('gitsigns').toggle_linehl,
                { buffer = bufnr, desc = 'Toggle line change highlight' })

            vim.keymap.set('n', '<leader>gga', require('gitsigns').stage_hunk,
                { buffer = bufnr, desc = 'Stage git hunk' })
            vim.keymap.set('n', '<leader>ggu', require('gitsigns').undo_stage_hunk,
                { buffer = bufnr, desc = 'Unstage git hunk' })
            vim.keymap.set('n', '<leader>ggr', require('gitsigns').reset_hunk,
                { buffer = bufnr, desc = 'Reset git hunk' })

            -- don't override the built-in and fugitive keymaps
            local gs = package.loaded.gitsigns
            vim.keymap.set({ 'n', 'v' }, ']c', function()
                if vim.wo.diff then return ']c' end
                vim.schedule(function() gs.next_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
            vim.keymap.set({ 'n', 'v' }, '[c', function()
                if vim.wo.diff then return '[c' end
                vim.schedule(function() gs.prev_hunk() end)
                return '<Ignore>'
            end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
        end,
    },
}
