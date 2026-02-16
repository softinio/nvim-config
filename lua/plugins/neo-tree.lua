return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = true,
  keys = {
    { "<leader>m", "<cmd>Neotree action=focus reveal toggle<cr>", desc = "NeoTree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      filesystem = {
        filtered_items = {
          visible = true,
        },
      },
      window = {
        width = 30,
        auto_expand_width = true,
        position = "right",
      },
    })
  end,
}
