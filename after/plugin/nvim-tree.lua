local installed, nvim_tree = pcall(require, 'nvim-tree')
if installed then
	vim.g.loaded_netrw = 1
	vim.g.loaded_netrwPlugin = 1
	nvim_tree.setup({
	  sort_by = "case_sensitive",
	  disable_netrw = true,
	  view = {
	    adaptive_size = true,
	    mappings = {
	      list = {
	        { key = "u", action = "dir_up" },
	      },
	    },
	  },
	  renderer = {
	    highlight_git = true,
	    group_empty = true,
	  },
	  filters = {
	    dotfiles = false,
	  },
	})

	vim.api.nvim_set_keymap('n', '<leader>m', [[<cmd>lua require('nvim-tree').toggle()<cr>]], { noremap = true, silent = true })
end
