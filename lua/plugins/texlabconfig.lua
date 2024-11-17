return {
  "f3fora/nvim-texlabconfig",
  build = "go build",
  dependencies = { "lervag/vimtex" },
  config = function()
    -- vimtex
    vim.g.vimtex_view_method = "sioyek"
    vim.g.vimtex_compiler_method = "tectonic"

    -- nvim-texlabconfig
    local tex_preview_executable = "zathura"
    local tex_preview_args = {
      "--reuse-window",
      "--execute-command",
      "toggle_synctex", -- Open Sioyek in synctex mode.
      "--inverse-search",
      [[nvim-texlabconfig -file %%%1 -line %%%2 -server ]] .. vim.v.servername,
      "--forward-search-file",
      "%f",
      "--forward-search-line",
      "%l",
      "%p",
    }
    local texlab_build_executable = "tectonic"
    local texlab_build_args = {
      "-X",
      "compile",
      "%f",
      "--synctex",
      "--keep-logs",
      "--keep-intermediates",
    }
    require("texlabconfig").setup({
      cache_activate = true,
      cache_filetypes = { "tex", "bib" },
      reverse_search_edit_cmd = vim.cmd.edit,
      settings = {
        texlab = {
          build = {
            executable = texlab_build_executable,
            args = texlab_build_args,
          },
          forwardSearch = {
            executable = tex_preview_executable,
            args = tex_preview_args,
          },
        },
      },
    })
  end,
}
