return {
  "nvim-lualine/lualine.nvim",
  lazy = false,
  config = function()
    require("lualine").setup({
      options = {
        icons_enabled = false,
        theme = "tokyonight",
        component_separators = "|",
        section_separators = "",
      },
    })
  end,
}
