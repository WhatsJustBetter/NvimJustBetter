# NvimJustBetter

## The only neovim config you should be using.

![NvimJustBetter](https://cdn.discordapp.com/attachments/1052738340887212092/1090064909070504026/image.png)
Not built-in background. Edit in your terminal settings.

## What is this?
* NvimJustBetter is a neovim config to make you wanna use neovim, without the hassle of configuring the whole thing.
* It has a good amount of plugins compiled with lazy.nvim for making the expirence better. Plus, you can add or remove as much as you want.
* We also made the keymaps easier to use. (Ctrl-C = Copy, Ctrl-Y = Paste, Ctrl-Z = Undo, Ctrl-Y = Redo)

## Installation
* Install a NERD font onto your terminal.<br>If you dont, weird icons like □ or � will show up most of the time.
<details>
<summary>Copy and Paste this code into init.lua.</summary>

```lua
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
 
	'neovim/nvim-lspconfig', -- Language Server Protocol
	
	'hrsh7th/cmp-nvim-lsp' -- Bridges LspConfig and Cmp

	'hrsh7th/nvim-cmp' -- Auto-completion
 
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

-- mason.nvim (LSP Installations)
require("mason").setup()
require("mason-lspconfig").setup()

-- nvim-cmp (Autocomplete)
local cmp = require("cmp")
cmp.setup({
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-o>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select=true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' }
	}),
})

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
--    Include Cmp Capabilities in setup   --

local capabilities = require('cmp_nvim_lsp').default_capabilities()
```
</details>

* Then, just reload/open neovim.
* Once all the plugins are installed, use `:q` to exit lazy.
* And your in! If you get any errors, make sure you have the **latest** version of Neovim.

## What plugins are included?

* Mason.nvim (Language Server installation)
* Mason LSP Config (Bridges Mason and LSPConfig)
* Neovim LSP Config (Language Server Protocol)
* Neovim Cmp LSP (Bridges LspConfig and Cmp)
* Neovim Cmp (Auto-completion)
* Catppuccin (The theme for NvimJustBetter)
* Treesitter (Better syntax highlighting)
* Lualine (Neovim Statusline)
* Neo-tree (Neovim sidebar file explorer)
* Telescope (Neovim fuzzy finder)
* Cokeline (Better tabline/bufferline)
* Auto-pairs (Closes parentheses, quotes, etc.)
* Vim-Closetag (Closes XML/HTML tags)
* Emmet-vim (HTML Emmet support)

## Thanks!
* [**Lufthansa**](https://about.jaybeegay.repl.co)<br>He's my friend who also codes a little bit, and wanted help setting up a auto-complete plugin on Neovim. There were alot of issues along the way because he was setting it up on a raspberry pi, and couldn't really get it working.<br>So the next day, I decided to make a simple, copy+paste, neovim config to make neovim accesible to everyone who's willing to try it.
* [**Me!**](https://about.hughwillson.repl.co)<br>I made the config, didn't I? I just wanted to switch from NVChad because of its lack of features, so I just decided to make my own for me and Lufthansa to use. Turns out, using lazy.nvim, it makes it so you dont have to download a single thing! Well, except a NERD font for your terminal.

### Thats about all I have to say about my config. Have a good day!
