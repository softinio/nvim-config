return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    vim.api.nvim_set_keymap("i", "<C-Tab>", 'copilot#Accept("<End>")', { silent = true, script = true, expr = true })
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
  end,
}
