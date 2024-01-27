local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable',
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- colorschemes
	--{ 'catppuccin/nvim' },
	--{ 'ellisonleao/gruvbox.nvim' },
	{ 'EdenEast/nightfox.nvim' },
	--{ 'rose-pine/neovim' },
	--{ 'rebelot/kanagawa.nvim' },
	{ 'nvim-lualine/lualine.nvim' },
	-- Telescope
	{ 'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = { 'nvim-lua/plenary.nvim' } },
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
	},
	-- LSP
	{ 'neovim/nvim-lspconfig' },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim' },
	-- completions
	{ 'hrsh7th/nvim-cmp' },
	{ 'hrsh7th/cmp-nvim-lsp' },
	{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
	{ 'L3MON4D3/LuaSnip',                   version = 'v2.*',   build = "make install_jsregexp" },
	-- debugging
	-- misc
	{ 'nvim-treesitter/nvim-treesitter',    build = ':TSUpdate' },
	{ 'm4xshen/autoclose.nvim' },
	{ 'nvim-tree/nvim-tree.lua' },
	{ 'nvim-tree/nvim-web-devicons' },
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		config = function()
			require('dashboard').setup {
				-- config
			}
		end,
		dependencies = { { 'nvim-tree/nvim-web-devicons' } }
	}
}

local opts = {
}

require('lazy').setup(plugins, opts)

local builtin = require('telescope.builtin')

local telescope = require('telescope')

telescope.setup {
	pickers = {
		find_files = {
			previewer = false,
			theme = 'dropdown'
		},
	},
	extensions = {
		file_browser = {
			theme = 'dropdown',
			previewer = false,
			hijack_netrw = true,
		}
	}
}
telescope.load_extension 'file_browser'

require('lualine').setup {
	options = {
		globalstatus = true
	},
}
--require('nvim-tree').setup()
require('mason').setup()
require('mason-lspconfig').setup()
require('autoclose').setup()

local cmp = require('cmp')

cmp.setup {
	snippet = {
		expand = function(args)
			require('luasnip').lsp_expand(args.body)
		end
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert {
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm { select = true }
	},
	sources = cmp.config.sources {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'nvim_lsp_signature_help' },
		{ name = 'buffer' }
	}
}

local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason-lspconfig').setup_handlers {
	function(server_name)
		lspconfig[server_name].setup {
			capabilities = capabilities,
		}
	end,
	['lua_ls'] = function()
		lspconfig.lua_ls.setup {
			settings = {
				Lua = {
					diagnostics = {
						globals = { 'vim' }
					}
				}
			}
		}
	end,
	['gopls'] = function()
		lspconfig.gopls.setup {
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
				}
			}
		}
	end
}

require('nvim-treesitter.configs').setup {
	ensure_installed = { "go" },
	sync_install = false,
	auto_install = true,
	ignore_install = { "javascript" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
}

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.g.mapleader = ' '
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd.colorscheme 'carbonfox'
vim.wo.nu = true
vim.wo.rnu = true
vim.wo.wrap = false
vim.o.fillchars = vim.o.fillchars .. "eob: "

vim.keymap.set('n', '<Leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<Leader>b', ':Telescope file_browser<CR>')
vim.keymap.set('n', '<Leader>f', function()
	vim.lsp.buf.format { async = true }
end)

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<space>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<space>f', function()
			vim.lsp.buf.format { async = true }
		end, opts)
	end,
})
