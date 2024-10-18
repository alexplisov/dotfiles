local M = {}

function M.compose()
	return string.format(
		" [%s] [%s]",
		vim.api.nvim_get_mode().mode,
		vim.api.nvim_buf_get_name(0)
	)
end

vim.o.statusline = "%!v:lua.require'config.statusline'.compose()"

return M
