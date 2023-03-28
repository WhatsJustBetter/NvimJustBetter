---         NvimJustBetter           ---
---      THE best neovim config      ---
---   No downloads, just copy+paste  ---
---                                  ---
---         Made by MJ 2.0           ---
---    about.hughwillson.repl.co     ---


-- Boot Lazy.nvim --
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

-- Good Mappings --
vim.g.mapleader = " "
vim.cmd([[
	inoremap <C-Z> <C-O>u
	inoremap <C-Y> <C-O><C-R>
	vmap <C-c> "+yi
	vmap <C-x> "+c
	vmap <C-v> c<ESC>"+p
	imap <C-v> <C-r><C-o>+
]])

-- Install Plugins --
require("lazy").setup({

	{ "williamboman/mason.nvim", build = ":MasonUpdate" }, -- Language server installation

	'williamboman/mason-lspconfig.nvim', -- Bridges Mason and LspConfig
 
	'neovim/nvim-lspconfig', -- Error checking and completion
 
	{ "catppuccin/nvim", name = "catppuccin" }, -- Neovim Theme

	{ 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"}, -- Better syntax highlighting
 
	{ "nvim-lualine/lualine.nvim", -- Neovim Statusline
    		dependencies = {
        		"nvim-tree/nvim-web-devicons",
    		},
	},
 
	{ "nvim-neo-tree/neo-tree.nvim", -- Neovim sidebar file explorer
		branch = "v2.x",
		dependencies = { 
			"MunifTanjim/nui.nvim", 
			"nvim-lua/plenary.nvim", 
			"nvim-tree/nvim-web-devicons",
		},
	},

	{ 'nvim-telescope/telescope.nvim', -- Neovim fuzzy finder
		branch = '0.1.1',
			dependencies = {
				'nvim-lua/plenary.nvim',
			},
		},

	'willothy/nvim-cokeline', -- Neovim Tabline
	
	'chun-yang/auto-pairs', -- Closes parentheses, quotes, etc.

	"alvan/vim-closetag", -- Closes XML tags

	'mattn/emmet-vim', -- Emmet for HTML files


	--             Add your own plugins!              --
	--   Use provided lazy.nvim install from github   --
	--  Or just go below and put 'author/repository', --
 
})


-- Setup and Configure Plugins --

-- mason.nvim (Error checking and completion)
require("mason").setup()
require("mason-lspconfig").setup()

-- catppuccin (Theme)
require("catppuccin").setup({
 flavour = "macchiato",
 transparent_background = true,
 coc_nvim = true,
})

-- lualine (Statusline)
require('lualine').setup({
 theme = "catppuccin"
})

-- neo-tree (File Explorer)
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- cokeline (Tabline)
require('cokeline').setup()

-- Set Colorscheme --
vim.cmd.colorscheme "catppuccin"
vim.cmd([[ set number ]]) -- Numbered Lines


--         SETUP LSP SERVERS HERE         --
--        LspConfig Pyright Setup:        --
--  require("lspconfig").pyright.setup{}  --
