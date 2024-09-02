return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "rcasia/neotest-java",
    "nvim-neotest/neotest-python",
    "stevanmilic/neotest-scala",
  },
  keys = {
    { "<leader>na", "<cmd>lua require('neotest').run.attach()<cr>", desc = "Attach to the nearest test" },
    { "<leader>nl", "<cmd>lua require('neotest').run.run_last()<cr>", desc = "Toggle Test Summary" },
    { "<leader>no", "<cmd>lua require('neotest').output_panel.toggle()<cr>", desc = "Toggle Test Output Panel" },
    { "<leader>np", "<cmd>lua require('neotest').run.stop()<cr>", desc = "Stop the nearest test" },
    { "<leader>ns", "<cmd>lua require('neotest').summary.toggle()<cr>", desc = "Toggle Test Summary" },
    { "<leader>nt", "<cmd>lua require('neotest').run.run()<cr>", desc = "Run the nearest test" },
    {
      "<leader>nT",
      "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
      desc = "Run test the current file",
    },
  },
  opts = {
    adapters = {
      ["neotest-java"] = {},
      ["neotest-python"] = {
        runner = "pytest",
        args = { "-vvv" },
        python = ".venv/bin/python",
      },
      ["neotest-scala"] = {
        runner = "sbt",
        command = "test",
        framework = "munit",
      },
    },
  },
}
