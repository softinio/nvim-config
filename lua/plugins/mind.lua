return {
  "phaazon/mind.nvim",
  branch = "v2.2",
  keys = {
    { "<leader>nm", "<cmd>MindOpenMain<cr>", desc = "Open Main Mind" },
    { "<leader>np", "<cmd>MindOpenProject<cr>", desc = "Open Mind for current project" },
    { "<leader>ns", "<cmd>MindOpenSmartProject<cr>", desc = "Open Mind for smart project" },
    { "<leader>nc", "<cmd>MindClose<cr>", desc = "Close Mind" },
    { "<leader>nr", "<cmd>MindReloadState<cr>", desc = "Mind: Reload State" },
  },
  config = function()
    require("mind").setup({
      persistence = {
        dataDir = "~/Documents/mind.nvim/data",
        statePath = "~/Documents/mind.nvim/mind.json",
      },
    })
  end,
}
