return {
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  {
    "folke/neodev.nvim",
    config = function()
      require("neodev").setup()
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("tokyonight").setup({
        style = "night",
        on_colors = function(colors)
          colors.bg = "#000000" -- "#1a1b26"
        end,
      })
      vim.o.termguicolors = true
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup()
    end,
  },
  { "folke/which-key.nvim", lazy = false },
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "LspAttach",
    config = function()
      require("fidget").setup()
    end,
  },
  {
    "windwp/nvim-autopairs",
    lazy = false,
    config = function()
      require("nvim-autopairs").setup()
    end,
  },
  "nvim-tree/nvim-web-devicons",
  "ckipp01/stylua-nvim",
  "gennaro-tedesco/nvim-jqx",
  "softinio/scaladex.nvim",
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = { char = "┊" },
      })
    end,
  },
  "SidOfc/mkdx",
}
