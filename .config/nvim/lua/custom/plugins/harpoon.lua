return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local harpoon = require("harpoon")

    harpoon:setup({})

    vim.keymap.set("n", "<leader>h", function() harpoon:list():add() end, { desc = 'Add file to harpoon' })
    vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<C-j>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)

    vim.keymap.set("n", "<leader>o", function() harpoon:list():prev() end, { desc = 'Go to prev in harpoon list' })
    vim.keymap.set("n", "<leader>i", function() harpoon:list():next() end, { desc = 'Go to next in harpoon list' })
  end,
}

