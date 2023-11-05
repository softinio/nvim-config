return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Notes/**.md",
    "BufNewFile " .. vim.fn.expand "~" .. "/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Notes/**.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>no", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch (Telescope)" },
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "Create a new obsidian note" },
    { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
    { "<leader>not", "<cmd>ObsidianToday<cr>", desc = "Obsidian new daily note" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
	path = "~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/Notes",
      },
    },
    use_advanced_uri = false,
  },
}

