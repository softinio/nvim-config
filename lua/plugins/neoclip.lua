return {
  "AckslD/nvim-neoclip.lua",
  dependencies = { "kkharji/sqlite.lua" },
  config = function()
    require("neoclip").setup({
      history = 1000,
      enable_persistent_history = true,
      db_path = vim.fn.stdpath("data") .. "~/.config/databases/neoclip.sqlite3",
      default_register = "+",
    })
  end,
}
