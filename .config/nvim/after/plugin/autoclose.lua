--require("autoclose").setup()

-- for autopairs:
require("nvim-autopairs").setup({
    check_ts = true,
    ignored_next_char = "[%w%.]",
    fast_wrap = {}, -- press alt-e while in this position (|)asfd to wrap word in parentheses
})
