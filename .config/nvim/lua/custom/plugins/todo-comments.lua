return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  config = function()
    require('todo-comments').setup {
      signs = false,
    }

    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
  end
}

-- FIX: fix
-- TODO: todo
-- HACK: hack
-- WARN: warn
-- PERF: perf
-- NOTE: note
-- TEST: test
