return {
  { "mrjones2014/smart-splits.nvim" },
  lazy = false,
  keys = {
    -- resizing splits
    { "n", "<A-a>", ":lua require('smart-splits').resize_left()<CR>" },
    { "n", "<A-o>", ":lua require('smart-splits').resize_down()<CR>" },
    { "n", "<A-e>", ":lua require('smart-splits').resize_up()<CR>" },
    { "n", "<A-u>", ":lua require('smart-splits').resize_right()<CR>" },
    -- moving between splits
    { "n", "<C-a>", ":lua require('smart-splits').move_cursor_left()<CR>" },
    { "n", "<C-o>", ":lua require('smart-splits').move_cursor_down()<CR>" },
    { "n", "<C-e>", ":lua require('smart-splits').move_cursor_up()<CR>" },
    { "n", "<C-u>", ":lua require('smart-splits').move_cursor_right()<CR>" },
    { "n", "<C-\\>", ":lua require('smart-splits').move_cursor_previous()<CR>" },
    -- swapping buffers between windows
    { "n", "<leader><leader>a", ":lua require('smart-splits').swap_buf_left()<CR>" },
    { "n", "<leader><leader>o", ":lua require('smart-splits').swap_buf_down()<CR>" },
    { "n", "<leader><leader>e", ":lua require('smart-splits').swap_buf_up()<CR>" },
    { "n", "<leader><leader>u", ":lua require('smart-splits').swap_buf_right()<CR>" },
  },
}
