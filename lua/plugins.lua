return function(use)
  use({'folke/trouble.nvim'})
  use({
    'folke/which-key.nvim',
      config = function()
        require('which-key').setup({})
      end
  })
  use({'windwp/nvim-autopairs'})
  use({'nvim-tree/nvim-web-devicons'})
  use({
    'nvim-tree/nvim-tree.lua',
    tag = 'nightly'
  })
  use({'ckipp01/stylua-nvim'})
  use({'gennaro-tedesco/nvim-jqx'})
  use({'lervag/vimtex'})
  use({
    'f3fora/nvim-texlabconfig',
    run = 'go build'
  })
  use({'sindrets/diffview.nvim'})
  use({'nvim-treesitter/playground'})
  use({ 'softinio/scaladex.nvim' })
  use({'TimUntersberger/neogit'})
end

