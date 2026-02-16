return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- Useful status updates for LSP
    "j-hui/fidget.nvim",

    -- schemas for json and yaml files
    "b0o/schemastore.nvim",

    -- LSP format on save
    "lukas-reineke/lsp-format.nvim",
  },
  config = function()
    -- Enable inlay hints
    vim.lsp.inlay_hint.enable(true)

    -- Enable diagnostic virtual text
    vim.diagnostic.config({
      virtual_text = true,
    })

    -- LSP settings.
    local lspconfig = require("lspconfig")

    -- Setup lsp-format
    require("lsp-format").setup({})

    -- This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(client, bufnr)
      -- Enable lsp-format on attach
      require("lsp-format").on_attach(client, bufnr)

      -- We create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      -- LSP keymaps matching nixvim
      nmap("gd", vim.lsp.buf.definition, "Go to definition")
      nmap("gD", require("telescope.builtin").lsp_references, "Go to references")
      nmap("gt", vim.lsp.buf.type_definition, "Go to type definition")
      nmap("gi", vim.lsp.buf.implementation, "Go to implementation")
      nmap("K", vim.lsp.buf.hover, "Hover documentation")
      nmap("<F2>", vim.lsp.buf.rename, "Rename")

      -- Additional useful LSP keymaps
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code action")
      nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "Document symbols")
      nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature help")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace add folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace remove folder")
      nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, "Workspace list folders")

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
      end, { desc = "Format current buffer with LSP" })
    end

    local servers = {
      -- Python
      basedpyright = {
        basedpyright = {
          analysis = {
            autoImportCompletions = true,
            autoSearchPaths = true,
            inlayHints = {
              callArgumentNames = true,
            },
            diagnosticMode = "openFilesOnly",
            reportMissingImports = true,
            reportMissingParameterType = true,
            reportUnnecessaryComparison = true,
            reportUnnecessaryContains = true,
            reportUnusedClass = true,
            reportUnusedFunction = true,
            reportUnsedImports = true,
            reportUnsusedVariables = true,
            typeCheckingMode = "recommended",
            useLibraryCodeForTypes = true,
          },
        },
      },
      -- Shell scripting
      bashls = {},
      -- Web development
      html = {},
      jsonls = {
        json = {
          format = {
            enable = true,
          },
          schemas = require("schemastore").json.schemas(),
          validate = true,
        },
      },
      ts_ls = {},
      yamlls = {},
      -- Query languages
      jqls = {},
      -- Lua
      lua_ls = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
      -- Documentation
      marksman = {},
      -- Nix
      nil_ls = {},
      nixd = {},
      -- Python pyrefly
      pyrefly = {},
      -- Rust
      rust_analyzer = {},
      -- Swift/iOS
      sourcekit = {},
      -- Typst
      tinymist = {},
      -- Zig
      zls = {},
    }

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Iterate over the servers table and configure each one
    for server, config in pairs(servers) do
      lspconfig[server].setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = config,
      })
    end
  end,
}
