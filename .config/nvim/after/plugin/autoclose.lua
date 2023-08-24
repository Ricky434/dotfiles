--require("autoclose").setup()

-- for autopairs:
local npairs = require"nvim-autopairs"
local Rule = require'nvim-autopairs.rule'

npairs.setup({
    check_ts = true,
    ignored_next_char = "[%w%.]",
    fast_wrap = {}, -- press alt-e while in this position (|)asfd to wrap word in parentheses
})


-- Add spaces between parentheses: (|) + space -> ( | )  and  ( | ) + ) -> (  )|
local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({
        brackets[1][1]..brackets[1][2],
        brackets[2][1]..brackets[2][2],
        brackets[3][1]..brackets[3][2],
      }, pair)
    end)
}
for _,bracket in pairs(brackets) do
  npairs.add_rules {
    Rule(bracket[1]..' ', ' '..bracket[2])
      :with_pair(function() return false end)
      :with_move(function(opts)
        return opts.prev_char:match('.%'..bracket[2]) ~= nil
      end)
      :use_key(bracket[2])
  }
end

-- Move past commas and semicolons: |, + , -> ,|
for _,punct in pairs { ",", ";" } do
    require "nvim-autopairs".add_rules {
        require "nvim-autopairs.rule"("", punct)
            :with_move(function(opts) return opts.char == punct end)
            :with_pair(function() return false end)
            :with_del(function() return false end)
            :with_cr(function() return false end)
            :use_key(punct)
    }
end
