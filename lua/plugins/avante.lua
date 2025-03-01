return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "claude",
    claude = {
      model = "claude-3-7-sonnet-latest",
      api_key_name = "cmd:cat " .. vim.fn.expand("~/.anthropic"),
    },
    openai = {
      model = "o3-mini",
      reasoning_effort = "high",
      api_key_name = "cmd:cat " .. vim.fn.expand("~/.openai"),
    },
    vendors = {
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "http://127.0.0.1:11434/v1",
        model = "qwen2.5-coder",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "HakonHarnes/img-clip.nvim",
    "MeanderingProgrammer/render-markdown.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
  },
}
