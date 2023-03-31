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
    
    	-- 'manzeloth/live-server',
 
})


-- Setup and Configure Plugins --

-- mason.nvim (LSP Installations)
require("mason").setup()
require("mason-lspconfig").setup()

-- onedark.nvim (Neovim Theme)
require('onedark').setup {
    style = 'deep'
}

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

local yellow = vim.g.terminal_color_3

require('cokeline').setup {
    default_hl = {
        fg = function(buffer)
          return
            buffer.is_focused
            and get_hex('Normal', 'fg')
             or get_hex('Comment', 'fg')
        end,
        bg = get_hex('ColorColumn', 'bg'),
      },

      components = {
        {
          text = ' ',
          bg = get_hex('Normal', 'bg'),
        },
        {
          text = '',
          fg = get_hex('ColorColumn', 'bg'),
          bg = get_hex('Normal', 'bg'),
        },
        {
          text = function(buffer)
            return buffer.devicon.icon
          end,
          fg = function(buffer)
            return buffer.devicon.color
          end,
        },
        {
          text = ' ',
        },
        {
          text = function(buffer) return buffer.filename .. '  ' end,
          style = function(buffer)
            return buffer.is_focused and 'bold' or nil
          end,
        },
        {
          text = '',
          delete_buffer_on_left_click = true,
        },
        {
          text = '',
          fg = get_hex('ColorColumn', 'bg'),
          bg = get_hex('Normal', 'bg'),
        },
    },
    sidebar = {
        filetype = 'neo-tree',
        components = {
            {
                text = "    Neo-tree",
                fg = vim.g.terminal_color_3,
                bg = get_hex("NeoTreeNormal", 'bg'),
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
vim.cmd([[ set number ]]) -- Numbered Lines


-- LSP Setup Helpers --
local lsp = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_setup = {
  on_attach = function(client, bufnr)
    require("lsp_signature").on_attach({
      bind = true, -- This is mandatory, otherwise border config won't get registered.
      handler_opts = {
        border = "rounded"
      }
    }, bufnr)
  end,
  capabilities=capabilities,
}
function add(t1, t2)
    return table.move(t2, 1, #t2, #t1 + 1, t1)
end

--               SETUP LSP SERVERS HERE                   --
--      Example Setup: lsp.pyright.setup(lsp_setup)       --
-- With Options: lsp.server.setup(add(lsp_setup, {opts})) --
