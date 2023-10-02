return {
  "windwp/nvim-autopairs",
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()

    local autopairs = require("nvim-autopairs")
    local rule_autopairs = require('nvim-autopairs.rule')

    autopairs.setup {
      check_ts = true,
      ignored_next_char = "[%w%.]",
      fast_wrap = {}, -- press alt-e while in this position (|)asfd to wrap word in parentheses
    }

    -- If you want to automatically add `(` after selecting a function or method
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on(
      'confirm_done',
      cmp_autopairs.on_confirm_done()
    )

    -- Add spaces between parentheses: (|) + space -> ( | )  and  ( | ) + ) -> (  )|
    local brackets = { { '(', ')' }, { '[', ']' }, { '{', '}' } }
    autopairs.add_rules {
      rule_autopairs(' ', ' ')
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
      autopairs.add_rules {
        rule_autopairs(bracket[1]..' ', ' '..bracket[2])
          :with_pair(function() return false end)
          :with_move(function(opts)
            return opts.prev_char:match('.%'..bracket[2]) ~= nil
          end)
          :use_key(bracket[2])
      }
    end

  end,
}
