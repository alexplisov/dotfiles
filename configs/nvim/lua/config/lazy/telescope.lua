return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local telescope = require('telescope')

		telescope.setup {
			pickers = {
				find_files = {
					previewer = false,
					theme = 'dropdown'
				},
			},
		}
	end
}
