-- I don't really understand how this plugin works
-- I just know that with builtin.foldfunc i can show folds without the stupid numbers
return {
  "luukvbaal/statuscol.nvim",
  config = function()
    local builtin = require("statuscol.builtin")
    require("statuscol").setup({
      -- Default segments (fold -> sign -> line number + separator), explained below
      segments = {
        { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" }, -- Fold column without numbers
        {
          text = { builtin.lnumfunc },
          condition = { true, builtin.not_empty },
          click = "v:lua.ScLa",
        },                                                               -- line number + separator
        { text = { " ", "%s"},       click = "v:lua.ScSa" },       -- sign
      },
    })
  end
}
