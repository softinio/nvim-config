return {
  "stevearc/conform.nvim",
  config = function()
    require("conform").setup({
      formatters_by_ft = {
      	lua = { "stylua" },
	python = function(bufnr)
	  if require("conform").get_formatter_info("ruff_format", bufnr).available then
	    return { "ruff_fix", "ruff_format" }
	  else
	    return { "isort", "black", "flake8" }
	  end
        end,
	scala = { "scalafmt" },
	swift = { "swift_format" },
        ["*"] = { "trim_whitespace", "trim_newlines" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    })
  end,
}
