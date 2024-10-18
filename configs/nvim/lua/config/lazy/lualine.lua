return {
	'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup {
			options = {
				icons_enabled = true,
				globalstatus = true,
				component_separators = { left = '', right = '' },
				section_separators = { left = '', right = '' },
			},
			sections = {
				lualine_a = {
					{
						'VimLogo',
						fmt = function()
							return ''
						end,
						padding = { left = 1, right = 0 }
					},
					{
						'mode',
						fmt = function(str)
							return str
						end,
						padding = { left = 1, right = 1 },
					}
				}
			}
		}
	end
}
