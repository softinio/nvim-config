return {
  "euclio/vim-markdown-composer",
  keys = {
    { "<leader>nv", "<cmd>ComposerStart<cr>", desc = "Composer Start" },
  },
  build = "cargo build --release --locked"
}

