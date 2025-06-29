return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "claude",
    providers = {
      claude = {
        model = "claude-sonnet-4-20250514",
        api_key_name = "cmd:cat " .. vim.fn.expand("~/.anthropic"),
      },
      openai = {
        model = "o4-mini",
        api_key_name = "cmd:cat " .. vim.fn.expand("~/.openai"),
        extra_request_body = {
          reasoning_effort = "high",
        },
      },
      ollama = {
        __inherited_from = "openai",
        api_key_name = "",
        endpoint = "http://127.0.0.1:11434",
        model = "qwen2.5-coder",
      },
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "HakonHarnes/img-clip.nvim",
    -- "MeanderingProgrammer/render-markdown.nvim",
    "nvim-tree/nvim-web-devicons",
    "nvim-treesitter/nvim-treesitter",
    "folke/snacks.nvim",
  },
}
