return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "BufReadPre " .. "'/Users/salar/Library/Mobile Documents/iCloud~md~obsidian/Documents/Softinio'",
    "BufNewFile " .. "'/Users/salar/Library/Mobile Documents/iCloud~md~obsidian/Documents/Softinio'",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>fo", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch (Telescope)" },
    { "<leader>fn", "<cmd>ObsidianNew<cr>", desc = "Create a new obsidian note" },
    { "<leader>fs", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
    { "<leader>fd", "<cmd>ObsidianToday<cr>", desc = "Obsidian new daily note" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "'/Users/salar/Library/Mobile Documents/iCloud~md~obsidian/Documents/Softinio'",
      },
    },
    use_advanced_uri = false,
  },
}
