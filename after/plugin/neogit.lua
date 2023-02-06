local installed, neogit = pcall(require, 'neogit')
if installed then
	neogit.setup {
	  integrations = {
	    diffview = true,
	  },
	}

	vim.api.nvim_set_keymap('n', '<leader>ng', [[<cmd>lua require('neogit').open({ kind = "split" })<cr>]], { noremap = true, silent = true })
end
