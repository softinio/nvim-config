return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  dependencies = { "sindrets/diffview.nvim" },
  config = function()
    require("neogit").setup({
      integrations = {
        diffview = true,
      },
    })
    vim.api.nvim_set_keymap(
      "n",
      "<leader>ng",
      [[<cmd>lua require('neogit').open({ kind = "split" })<cr>]],
      { noremap = true, silent = true }
    )
  end,
}
