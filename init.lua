if vim.g.vscode then
  -- VSCode Neovim
  require("user.vscode_keymaps")
else
  local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  require("lazy").setup("plugins", {
    lockfile = vim.fn.stdpath("data") .. "/lazy-lock.json", -- in data directory as normal location read only as managed by nix
    dev = {
      path = "~/Projects/Neovim",
    },
  })

  -- [[ Setting options ]]
  -- See `:help vim.o`

  -- conceal level (needed for obsidian)
  vim.o.conceallevel = 1

  -- Set highlight on search
  vim.o.hlsearch = true
  vim.o.incsearch = true

  -- clipboard
  vim.o.clipboard = "unnamedplus"

  -- Make line numbers default
  vim.wo.number = true

  -- Enable mouse mode
  vim.o.mouse = "a"

  -- Enable break indent
  vim.o.breakindent = true

  -- smart indenting
  vim.o.smartindent = true

  -- Save undo history
  vim.o.undofile = true

  -- Case insensitive searching UNLESS /C or capital in search
  vim.o.ignorecase = true
  vim.o.smartcase = true

  -- Decrease update time
  vim.o.updatetime = 250
  vim.wo.signcolumn = "yes"

  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1

  -- Set completeopt to have a better completion experience
  vim.o.completeopt = "menuone,noselect"

  -- [[ Basic Keymaps ]]

  -- Keymaps for better default experience
  -- See `:help vim.keymap.set()`
  vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

  -- Remap for dealing with word wrap
  vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- [[ Highlight on yank ]]
  -- See `:help vim.highlight.on_yank()`
  local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
  vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
      vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
  })

  -- sets the tab size for json files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "json", "lua", "nix" },
    callback = function()
      vim.bo.tabstop = 2
      vim.bo.shiftwidth = 2
      vim.bo.expandtab = true
    end,
  })

  -- Terminal Escape Key Mapping
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

  -- Diagnostic keymaps
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
  vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

  -- The line beneath this is called `modeline`. See `:help modeline`
  -- vim: ts=2 sts=2 sw=2 et
end
