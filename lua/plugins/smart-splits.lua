return {
  { "mrjones2014/smart-splits.nvim" },
  lazy = false,
  keys = {
    -- resizing splits
    { "<A-a>", ":lua require('smart-splits').resize_left()<CR>", desc = "smart split: resize left" },
    { "<A-o>", ":lua require('smart-splits').resize_down()<CR>", desc = "smart split: resize down" },
    { "<A-e>", ":lua require('smart-splits').resize_up()<CR>", desc = "smart split: resize up" },
    { "<A-u>", ":lua require('smart-splits').resize_right()<CR>", desc = "smart split: resize right" },
    -- moving between splits
    { "<C-a>", ":lua require('smart-splits').move_cursor_left()<CR>", desc = "smart split: move cursor left" },
    { "<C-o>", ":lua require('smart-splits').move_cursor_down()<CR>", desc = "smart split: move cursor up" },
    { "<C-e>", ":lua require('smart-splits').move_cursor_up()<CR>", desc = "smart split: move cursor up" },
    { "<C-u>", ":lua require('smart-splits').move_cursor_right()<CR>", desc = "smart split: move cursor right" },
    {
      "<C-\\>",
      ":lua require('smart-splits').move_cursor_previous()<CR>",
      desc = "smart split: move cursor to previous",
    },
    -- swapping buffers between windows
    { "<leader><leader>a", ":lua require('smart-splits').swap_buf_left()<CR>", desc = "smart split: swap left" },
    { "<leader><leader>o", ":lua require('smart-splits').swap_buf_down()<CR>", desc = "smart split: swap down" },
    { "<leader><leader>e", ":lua require('smart-splits').swap_buf_up()<CR>", desc = "smart split: swap up" },
    { "<leader><leader>u", ":lua require('smart-splits').swap_buf_right()<CR>", desc = "smart split: swap right" },
  },
}
