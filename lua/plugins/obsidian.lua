return {
  "epwalsh/obsidian.nvim",
  lazy = true,
  event = {
    "BufReadPre " .. vim.fn.expand "~" .. "/obsidian",
    "BufNewFile " .. vim.fn.expand "~" .. "/obsidian",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>no", "<cmd>ObsidianQuickSwitch<cr>", desc = "Obsidian Quick Switch (Telescope)" },
    { "<leader>nn", "<cmd>ObsidianNew<cr>", desc = "Create a new obsidian note" },
    { "<leader>ns", "<cmd>ObsidianSearch<cr>", desc = "Obsidian Search" },
    { "<leader>nd", "<cmd>ObsidianToday<cr>", desc = "Obsidian new daily note" },
  },
  opts = {
    workspaces = {
      {
        name = "personal",
	path = "~/obsidian",
      },
    },
    use_advanced_uri = false,
  },
}

