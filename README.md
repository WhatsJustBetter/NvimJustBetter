# NvimJustBetter

## The only neovim config you should be using.

![NvimJustBetter](https://cdn.discordapp.com/attachments/1052738340887212092/1090064909070504026/image.png)
Not built-in background. Edit in your terminal settings.

## What is this?
* NvimJustBetter is a neovim config to make you wanna use neovim, without the hassle of configuring the whole thing.
* It has a good amount of plugins compiled with lazy.nvim for making the expirence better. Plus, you can add or remove as much as you want.
* We also made the keymaps easier to use. (Ctrl-C = Copy, Ctrl-Y = Paste, Ctrl-Z = Undo, Ctrl-Y = Redo)

## Installation
* On debian based systems, run install.sh

* Install a NERD font onto your terminal.<br>If you dont, weird icons like □ or � will show up most of the time.
<details>
<summary>Copy and Paste this code into init.lua.</summary>

```lua
---         NvimJustBetter           ---
---                                  ---
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
	set tabstop=4
	set shiftwidth=4
	set expandtab
    autocmd CursorHold,CursorHoldI * update
]])

-- Install Plugins --
require("lazy").setup({

	{ "williamboman/mason.nvim", build = ":MasonUpdate" }, -- Language server installation

	'williamboman/mason-lspconfig.nvim', -- Bridges Mason and LspConfig

	'neovim/nvim-lspconfig', -- Language Server Protocol

	'hrsh7th/cmp-nvim-lsp', -- Bridges LspConfig and Cmp

	'hrsh7th/nvim-cmp', -- Auto-completion

    'hrsh7th/cmp-vsnip', -- Bridges Vsnip and Cmp

    'hrsh7th/vim-vsnip', -- Snippets

    'ray-x/lsp_signature.nvim', -- Function Arguments

	'navarasu/onedark.nvim', -- Neovim Theme

	{ 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate"}, -- Better syntax highlighting

    'jose-elias-alvarez/null-ls.nvim', -- Bridges Lsp and Prettier

    'MunifTanjim/prettier.nvim',

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

	'windwp/nvim-autopairs', -- Closes parentheses, quotes, etc.

	"alvan/vim-closetag", -- Closes XML tags

	'mattn/emmet-vim', -- Emmet for HTML files


	--             Add your own plugins!              --
	--   Use provided lazy.nvim install from github   --
	--  Or just go below and put 'author/repository', --

    'manzeloth/live-server',

})


-- Setup and Configure Plugins --

-- mason.nvim (LSP Installations)
require("mason").setup()
require("mason-lspconfig").setup()

-- LspConfig (Error highlighting)
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = true,
    severity_sort = false,
})
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- onedark.nvim (Neovim Theme)
require('onedark').setup {
    style = 'deep'
}

-- null-ls
require("null-ls").setup()

-- prettier (Colorful Syntax Highlighting)
require("prettier").setup()

-- nvim-cmp (Autocomplete)
local cmp = require("cmp")
cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-o>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select=true }),
	}),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
        { name = 'vsnip' },
	}, {
		{ name = 'buffer' }
	}),
})

-- lualine (Statusline)
require('lualine').setup()

-- neo-tree (File Explorer)
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- cokeline (Tabline)
local get_hex = require('cokeline/utils').get_hex

local space = {text = "    "}

require('cokeline').setup {
            mappings = {
              cycle_prev_next = true,
            },
            default_hl = {
              fg = function(buffer)
                return
                  buffer.is_focused and nil or get_hex("Comment", "fg")
              end,
              bg = "none",
            },
            components = {
                space,
                {
                    text = function(buffer)
                        return buffer.devicon.icon
                    end,
                    fg = function(buffer)
                        return buffer.devicon.color
                    end
                },
                {
                    text = function(buffer)
                        return buffer.filename
                    end,
                    fg = function(buffer)
                        if buffer.is_focused then
                            return "#78dce8"
                        end
                        if buffer.is_modified then
                            return "#e5c463"
                        end
                        if false then
                            return "#fc5d7c"
                        end
                    end,
                    style = function(buffer)
                        if buffer.is_focused then
                            return "underline"
                        end
                        return nil
                    end
                },
                {
                    text = function(buffer)
                        if buffer.is_readonly then
                            return " 🔒"
                        end
                        return ""
                    end
                },
                space
            },
    sidebar = {
        filetype = 'neo-tree',
        components = {
            {
                text = "    Neo-tree",
                fg = vim.g.terminal_color_3,
                bg = get_hex("NeoTreeNormal"),
                style = 'bold'
            }
        }
    }
}

-- auto-pairs (Closes parentheses, quotes, etc.)
require("nvim-autopairs").setup {}
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- LSP Signature (Function Arguments)
require("lsp_signature").setup()

-- Set Colorscheme --
require('onedark').load()
vim.cmd([[
    set number 
    set cursorline
    highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
]]) -- Numbered Lines

-- LSP Setup Helpers --
local lsp = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_setup = {
    on_attach = function(_, bufnr)
        require("lsp_signature").on_attach({
            bind = true, -- This is mandatory, otherwise border config won't get registered.
            handler_opts = {
                border = "rounded"
            }
        }, bufnr)
    end,
  capabilities=capabilities,
}
local function add(t1, t2)
    return table.move(t2, 1, #t2, #t1 + 1, t1)
end

--               SETUP LSP SERVERS HERE                   --
--      Example Setup: lsp.pyright.setup(lsp_setup)       --
-- With Options: lsp.server.setup(add(lsp_setup, {opts})) --
```
</details>

* Then, just reload/open neovim.
* Once all the plugins are installed, use `:q` to exit lazy.
* Then, run :MasonUpdate
* And your in! If you get any errors, make sure you have the **latest** version of Neovim.

## What plugins are included?

* Mason.nvim (Language Server installation)
* Neovim LSP Config (Language Server Protocol)
* Neovim Cmp (Auto-completion)
* v-snip (Snippets for Cmp)
* LSP Signature (Function Arguments)
* Neovim One Dark (The theme for NvimJustBetter)
* Treesitter (Better syntax highlighting)
* Lualine (Neovim Statusline)
* Neo-tree (Neovim sidebar file explorer)
* Telescope (Neovim fuzzy finder)
* Cokeline (Better tabline/bufferline)
* Neovim Auto-pairs (Closes parentheses, quotes, etc.)
* Vim-Closetag (Closes XML/HTML tags)
* Emmet-vim (HTML Emmet support)

## Thanks!
* [**Lufthansa**](https://jaythedev.com)<br>He's my friend who also codes a little bit, and wanted help setting up a auto-complete plugin on Neovim. There were alot of issues along the way because he was setting it up on a raspberry pi, and couldn't really get it working.<br>So the next day, I decided to make a simple, copy+paste, neovim config to make neovim accesible to everyone who's willing to try it.
* [**Me!**](https://about.hughwillson.repl.co)<br>I made the config, didn't I? I just wanted to switch from NVChad because of its lack of features, so I just decided to make my own for me and Lufthansa to use. Turns out, using lazy.nvim, it makes it so you dont have to download a single thing! Well, except a NERD font for your terminal.

### Thats about all I have to say about my config. Have a good day!
