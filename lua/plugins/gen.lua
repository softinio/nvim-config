return {
  "David-Kunz/gen.nvim",
  lazy = false,
  keys = {
    { "<leader>ai", ":Gen<CR>", mode = { "n", "v" }, desc = "AI tools using Ollama" },
    { "<leader>aa", ":Gen Ask<CR>", mode = { "n", "v" }, desc = "[A]I [A]sk" },
    {
      "<leader>am",
      function()
        require("gen").select_model()
      end,
      mode = { "n", "v" },
      desc = "Select [A]I [m]odel",
    },
  },
  config = function()
    require("gen").setup({
      ollama = {
        model = "codellama",
        host = "localhost",
        port = "11434",
        quit_map = "q",
        retry_map = "<c-r>",
        init = function(options)
          pcall(io.popen, "ollama serve > /dev/null 2>&1 &")
        end,
        command = function(options)
          local body = { model = options.model, stream = true }
          return "curl --silent --no-buffer -X POST http://"
            .. options.host
            .. ":"
            .. options.port
            .. "/api/chat -d $body"
        end,
        display_mode = "split", -- "split" or "float"
        show_prompt = true,
        show_model = true,
        no_auto_close = false,
        debug = false,
      },
    })
    require("gen").prompts["Fix_Code"] = {
      prompt = "Fix the following code. Only ouput the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
      replace = true,
      extract = "```$filetype\n(.-)```",
    }
  end,
}
