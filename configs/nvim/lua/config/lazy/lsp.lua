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
		local icons = {
			Text = "TXT",
			Variable = "Var",
			Snippet = "Snip"
		}

		require('mason').setup()
		mason_lspconfig.setup()
		mason_lspconfig.setup_handlers {
			function(server_name)
				lspconfig[server_name].setup {
					capabilities = capabilities,
				}
			end,
			['lua_ls'] = function()
				lspconfig.lua_ls.setup {
					capabilities = capabilities,
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
			formatting = {
				format = function(_, vim_item)
					-- vim_item.kind = icons[vim_item.kind] or ""
					return vim_item
				end
			}
		}
	end
}
