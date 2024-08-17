return {
	{
		'mfussenegger/nvim-dap',
		dependencies = {
			'rcarriga/nvim-dap-ui',
			'nvim-neotest/nvim-nio'
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local mason_dap = require('mason-nvim-dap')

			dapui.setup()
			mason_dap.setup({
				handlers = {
					function(config)
						mason_dap.default_setup(config)
					end
				}
			})

			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end

			vim.keymap.set('n', '<space>db', dap.toggle_breakpoint, {})
			vim.keymap.set('n', '<space>dc', dap.continue, {})
		end,
	},
	{ 'jay-babu/mason-nvim-dap.nvim' },
}
