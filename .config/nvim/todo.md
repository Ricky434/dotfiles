Nvim-treesitter esploso, molte cose adesso direttamente dentro nvim core
-> cose da migrare:
- trova modo di disabilitare highlighting per latex
- incremental selection keybinds cozzano con quelli di mini.surround (per ora disabilitato)
- non so se questa roba e' stata direttamente implementata o va migrata
        require('nvim-treesitter.configs').setup {
            highlight = {
                enable = true,
                disable = { 'latex' }, -- Handled by vimTex
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                disable = { 'latex' },
                -- Keymaps for selecting text based on nodes
                keymaps = {
                    init_selection = '<c-space>',
                    node_incremental = '<c-space>',
                    scope_incremental = '<c-s>',
                    node_decremental = '<M-space>',
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    disable = { 'latex' },
                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    },
                },
                move = {
                    enable = true,
                    disable = { 'latex' },
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer',
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                },
                swap = {
                    enable = true,
                    disable = { 'latex' },
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
            },
        }

