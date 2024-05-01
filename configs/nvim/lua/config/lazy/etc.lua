return {
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
		'm4xshen/autoclose.nvim',
		config = function()
			require('autoclose').setup()
		end
	},
	{ 'nvim-tree/nvim-web-devicons' },
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}
}
