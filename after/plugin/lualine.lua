local installed, lualine = pcall(require, "lualine")
if installed then
  -- Set lualine as statusline
  -- See `:help lualine.txt`
  lualine.setup({
    options = {
      icons_enabled = false,
      theme = "tokyonight",
      component_separators = "|",
      section_separators = "",
    },
  })
end
