return {
  'folke/which-key.nvim',
  opts = {
    icons = {
      mappings = false,
    },
    triggers = {
      {
        "s", mode = {"n"} -- because it is not a prefix by default, i had to noremap it
      },
      {
        "<leader>", mode = {"n", "v"},
      }
    }
  },
}
