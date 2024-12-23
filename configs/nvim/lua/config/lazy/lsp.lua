return {
	'neovim/nvim-lspconfig',
	dependencies = {
		'williamboman/mason.nvim',
		'williamboman/mason-lspconfig.nvim',
		'hrsh7th/nvim-cmp',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lsp-signature-help',
		'L3MON4D3/LuaSnip',
	},
	config = function()
		local cmp = require('cmp')
		local lspconfig = require('lspconfig')
		local mason_lspconfig = require('mason-lspconfig')
		local capabilities = require('cmp_nvim_lsp').default_capabilities()

		require('neodev').setup()

		require('mason').setup()
		mason_lspconfig.setup()
		mason_lspconfig.setup_handlers {
			function(server_name)
				lspconfig[server_name].setup {
					capabilities = capabilities,
				}
			end,
			['gopls'] = function()
				lspconfig.gopls.setup {}
			end
		}

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
				['<c-b>'] = cmp.mapping.scroll_docs(-4),
				['<c-f>'] = cmp.mapping.scroll_docs(4),
				['<c-space>'] = cmp.mapping.complete(),
				['<c-e>'] = cmp.mapping.abort(),
				['<cr>'] = cmp.mapping.confirm { select = true }
			},
			sources = cmp.config.sources {
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
				{ name = 'nvim_lsp_signature_help' },
				{ name = 'buffer' }
			},
		}

		-- Format on save
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp", { clear = true }),
			callback = function(args)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = args.buf,
					callback = function()
						vim.lsp.buf.format { async = false, id = args.data.client_id }
					end,
				})
			end
		})
	end
}
