return {
	{ 'folke/neodev.nvim',          opts = {} },
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
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
		end
	},
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
		end
	},
	{ 'nvim-tree/nvim-web-devicons' },
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			require('nvim-tree').setup {
				actions = {
					open_file = {
						quit_on_open = true
					}
				}
			}
		end
	}
}
