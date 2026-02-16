return {
  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")

      -- DAP signs
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DapBreakpoint" })
      vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint" })
      vim.fn.sign_define("DapStopped", { text = "→", texthl = "DapStopped" })

      -- Scala DAP configurations
      dap.configurations.scala = {
        {
          type = "scala",
          request = "launch",
          name = "Run or Test Target",
          metals = {
            runType = "runOrTestFile",
          },
        },
        {
          type = "scala",
          request = "launch",
          name = "Test Target",
          metals = {
            runType = "testTarget",
          },
        },
      }

      -- Automatically setup DAP when Metals attaches
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "sc" },
        callback = function()
          local ok, metals = pcall(require, "metals")
          if ok and metals.setup_dap then
            metals.setup_dap()
          end
        end,
      })

      -- DAP keybindings
      vim.keymap.set("n", "<leader>db", function()
        require("dap").toggle_breakpoint()
      end, { silent = true, desc = "Toggle breakpoint" })

      vim.keymap.set("n", "<leader>dc", function()
        require("dap").continue()
      end, { silent = true, desc = "Continue debugging" })

      vim.keymap.set("n", "<leader>ds", function()
        require("dap").step_over()
      end, { silent = true, desc = "Step over" })

      vim.keymap.set("n", "<leader>di", function()
        require("dap").step_into()
      end, { silent = true, desc = "Step into" })

      vim.keymap.set("n", "<leader>do", function()
        require("dap").step_out()
      end, { silent = true, desc = "Step out" })

      vim.keymap.set("n", "<leader>dt", function()
        require("dap").terminate()
      end, { silent = true, desc = "Terminate debugging" })

      vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
      end, { silent = true, desc = "Toggle DAP UI" })

      vim.keymap.set("n", "<leader>dh", function()
        require("dap.ui.widgets").hover()
      end, { silent = true, desc = "Hover variable value" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup({
        floating = {
          mappings = {
            close = { "<Esc>", "q" },
          },
        },
      })
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    config = function()
      require("nvim-dap-virtual-text").setup()
    end,
  },
}
