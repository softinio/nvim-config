return {
  "phaazon/mind.nvim",
  branch = "v2.2",
  config = function()
    require("mind").setup({
      persistence = {
            dataDir = "~/Documents/mind.nvim/data";
            statePath = "~/Documents/mind.nvim/mind.json";
      },
    })
  end,
}
