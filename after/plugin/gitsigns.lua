local installed, gitsigns = pcall(require, 'gitsigns')
if installed then
	gitsigns.setup {
	  signs = {
	    add = { text = '+' },
	    change = { text = '~' },
	    delete = { text = '_' },
	    topdelete = { text = '‾' },
	    changedelete = { text = '~' },
	  },
	}
end
