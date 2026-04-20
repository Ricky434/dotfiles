local function pandoc_compile()
    local filepath = vim.api.nvim_buf_get_name(0)
    local cwd = filepath:match("(.*[\\/])")
    local filename = filepath:match(".*[\\/](.*)")

    -- extract file name without extension
    local occurrences = {}
    ---@type integer|nil
    local i = 0
    while true do
        i = string.find(filename, "%.", i + 1)
        if i == nil then break end
        table.insert(occurrences, i)
    end
    local fnameNoExt = string.sub(filename, 1, occurrences[#occurrences] - 1)

    local outpath = cwd .. fnameNoExt .. '.pdf'
    -- Runs asynchronously:
    local obj = vim.system({
        'pandoc', '-o', outpath,
        '--number-sections',
        '--from', 'markdown+mark+lists_without_preceding_blankline+short_subsuperscripts+link_attributes',
        filepath
    }, { text = true }):wait()

    print(obj.stderr)
end

vim.api.nvim_create_user_command('PandocCompile', function(_)
    pandoc_compile()
end, { desc = 'Compile file to pdf with pandoc' })

-- Configuration for markdown files
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "md", "markdown" },
    group = vim.api.nvim_create_augroup('pandoc_on_save', { clear = true }),
    callback = function(opts)
        local compile_is_enabled = false
        vim.api.nvim_create_user_command('PandocOnWriteToggle', function()
            compile_is_enabled = not compile_is_enabled
            print('Setting autocompiling to pdf to: ' .. tostring(compile_is_enabled))
        end, {})

        -- Use pandoc to create pdf from markdown on write, if toggle is enabled
        vim.api.nvim_create_autocmd('BufWritePost', {
            buffer = opts.buf,
            callback = function()
                if not compile_is_enabled then
                    return
                end

                pandoc_compile()
            end,
        })
    end
})

vim.keymap.set('n', '<leader>mc', pandoc_compile, { desc = 'Compile markdown to pdf with Pandoc' })
