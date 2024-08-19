local builtin = require('telescope.builtin')
local nvim_tree = require('nvim-tree')

vim.keymap.set('n', '<leader>sf', builtin.find_files, {})
vim.keymap.set('n', '<leader>f', function()
	vim.lsp.buf.format { async = true }
end)

-- Tabs
vim.keymap.set('n', '<leader>te', ':tabnew<CR>', {})
vim.keymap.set('n', '<leader>tw', ':tabclose<CR>', {})
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', {})
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', {})

vim.keymap.set('n', '<leader>b', ':NvimTreeToggle<CR>', {})

vim.api.nvim_create_autocmd('lspattach', {
	group = vim.api.nvim_create_augroup('userlspconfig', {}),
	callback = function(ev)
		-- enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

		-- buffer local mappings.
		-- see `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf }
		vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
		vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
		vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, opts)
		vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set('n', '<leader>wl', function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set('n', '<leader>d', vim.lsp.buf.type_definition, opts)
		vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
		vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
		vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
		vim.keymap.set('n', '<leader>lf', function()
			vim.lsp.buf.format { async = true }
		end, opts)
		vim.keymap.set('n', '<leader>gl', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '<leader>gn', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<leader>gp', vim.diagnostic.goto_prev, opts)
	end,
})
