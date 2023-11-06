return {
  "nvim-neorg/neorg",
  lazy = false,
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Neorg index" },
    { "<leader>nw", "<cmd>Neorg generate-workspace-summary<cr>", desc = "Neorg generate Workspace Summary" },
    { "<leader>njt", "<cmd>Neorg journal today<cr>", desc = "Neorg Journal Today" },
    { "<leader>njT", "<cmd>Neorg journal template<cr>", desc = "Neorg Journal Template" },
  },
  config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.summary"] = {},
          ["core.concealer"] = {
            config = {
              icon_preset = "diamond",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
                til = "~/til",
              },
              default_workspace = "notes",
            },
          },
        },
      }
    end,
}
