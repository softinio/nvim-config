return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Useful status updates for LSP
    "j-hui/fidget.nvim",

    -- Additional lua configuration, makes nvim stuff amazing
    "folke/neodev.nvim",

    -- schemas for json and yaml files
    "b0o/schemastore.nvim",
  },
  config = function()
    -- LSP settings.
    -- Require the lspconfig module
    local lspconfig = require("lspconfig")
    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      -- We create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
      nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

      nmap("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
      nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
      nmap("gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
      nmap("<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "[W]orkspace [L]ist Folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    local servers = {
      basedpyright = {
        analysis = {
          autoImportCompletions = true,
          autoSearchPaths = true,
          diagnosticMode = "openFilesOnly",
          reportMissingImports = true,
          reportMissingParameterType = true,
          reportUnnecessaryComparison = true,
          reportUnnecessaryContains = true,
          reportUnusedClass = true,
          reportUnusedFunction = true,
          reportUnsedImports = true,
          reportUnsusedVariables = true,
          typeCheckingMode = "all",
          useLibraryCodeForTypes = true,
        },
      },
      bashls = {
        bashIde = {
          globPattern = "*@(.sh|.inc|.bash|.command)",
        },
      },
      html = {},
      jqls = {},
      jsonls = {
        json = {
          format = {
            enable = true,
          },
          schemas = require("schemastore").json.schemas(),
          validate = true,
        },
      },
      lua_ls = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      marksman = {},
      nil_ls = {},
      nixd = {},
      pyrefly = {},
      rust_analyzer = {
        diagnostics = {
          enable = true,
        },
      },
      sourcekit = {
        workspace = {
          didChangeConfiguration = {
            dynamicRegistration = true,
          },
        },
      },
      ts_ls = {},
      yamlls = {},
    }
    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Iterate over the servers table and configure each one
    for server, config in pairs(servers) do
      -- Set up the server using the `config` if provided, otherwise just `on_attach` and `capabilities`
      lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = config, -- Pass the specific server settings here
      })
    end
  end,
}
