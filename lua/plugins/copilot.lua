return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    vim.api.nvim_set_keymap(
      "i",
      "<C-J>",
      'copilot#Accept("\\<CR>")',
      { silent = true, script = true, expr = true, replace_keycodes = false }
    )
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
  end,
}
