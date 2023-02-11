return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  dependencies = { "sindrets/diffview.nvim" },
  keys = {
    { "<leader>ng", "<cmd>Neogit<cr>", desc = "Neogit" },
  },
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
      },
    })
    local group = vim.api.nvim_create_augroup("MyCustomNeogitEvents", { clear = true })
    vim.api.nvim_create_autocmd("User", {
      pattern = "NeogitPushComplete",
      group = group,
      callback = require("neogit").close,
    })
  end,
}
