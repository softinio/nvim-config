return {
  "scalameta/nvim-metals",
  lazy = false,
  keys = {
    { "<leader>ws", "<cmd>lua require'metals'.hover_worksheet()<cr>", desc = "Metals Worksheet" },
    {
      "<leader>sm",
      "<cmd>lua require'telescope'.extensions.metals.commands()<cr>",
      desc = "Telescope Metals Commands",
    },
  },
  config = function()
    local metals_config = require("metals").bare_config()
    metals_config.tvp = {
      icons = {
        enabled = true,
      },
    }

    metals_config.settings = {
      serverVersion = "latest.snapshot",
      useGlobalExecutable = true,
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      showInferredType = true,
      bloopSbtAlreadyInstalled = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      -- fallbackScalaVersion = "2.13.8",
      superMethodLensesEnabled = true,
    }

    metals_config.on_attach = function(client, bufnr)
      vim.keymap.set("n", "<leader>tt", require("metals.tvp").toggle_tree_view)
      vim.keymap.set("n", "<leader>tr", require("metals.tvp").reveal_in_tree)
      vim.cmd([[autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()]])
      vim.cmd([[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]])
      vim.cmd([[autocmd BufEnter,CursorHold,InsertLeave <buffer> lua vim.lsp.codelens.refresh()]])
    end

    metals_config.init_options.statusBarProvider = "on"

    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end,
}
