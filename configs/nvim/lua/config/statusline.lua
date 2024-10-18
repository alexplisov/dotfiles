local M = {}

vim.api.nvim_set_hl(0, 'StatusDecoration', { reverse = false })
vim.api.nvim_set_hl(0, 'StatusText', { reverse = true })

function M.mode()
	local mode_to_str = {
        ['n'] = 'NORMAL',
        ['no'] = 'OP-PENDING',
        ['nov'] = 'OP-PENDING',
        ['noV'] = 'OP-PENDING',
        ['no\22'] = 'OP-PENDING',
        ['niI'] = 'NORMAL',
        ['niR'] = 'NORMAL',
        ['niV'] = 'NORMAL',
        ['nt'] = 'NORMAL',
        ['ntT'] = 'NORMAL',
        ['v'] = 'VISUAL',
        ['vs'] = 'VISUAL',
        ['V'] = 'VISUAL',
        ['Vs'] = 'VISUAL',
        ['\22'] = 'VISUAL',
        ['\22s'] = 'VISUAL',
        ['s'] = 'SELECT',
        ['S'] = 'SELECT',
        ['\19'] = 'SELECT',
        ['i'] = 'INSERT',
        ['ic'] = 'INSERT',
        ['ix'] = 'INSERT',
        ['R'] = 'REPLACE',
        ['Rc'] = 'REPLACE',
        ['Rx'] = 'REPLACE',
        ['Rv'] = 'VIRT REPLACE',
        ['Rvc'] = 'VIRT REPLACE',
        ['Rvx'] = 'VIRT REPLACE',
        ['c'] = 'COMMAND',
        ['cv'] = 'VIM EX',
        ['ce'] = 'EX',
        ['r'] = 'PROMPT',
        ['rm'] = 'MORE',
        ['r?'] = 'CONFIRM',
        ['!'] = 'SHELL',
        ['t'] = 'TERMINAL',
    }

	return "[" .. mode_to_str[vim.api.nvim_get_mode().mode] .. "]"
end

function M.filetype()
	local devicons = require 'nvim-web-devicons'
	local buf_name = vim.api.nvim_buf_get_name(0)
	local name, ext = vim.fn.fnamemodify(buf_name, ':t'), vim.fn.fnamemodify(buf_name, ':e')
	local icon = devicons.get_icon(name, ext)

	if icon ~= nil then
		return string.format("%%#StatusText#[%s %s]", icon, vim.fn.expand('%:t'))
	else
		return ""
	end
end

function M.cursor_position()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	return string.format("%%#StatusText#[%s:%s]", row, col)
end

function M.compose()
	return string.format(
		"%%#StatusDecoration#%%#StatusText#  %s %s %%= %s%%#StatusDecoration#",
		M.mode(),
		M.filetype(),
		M.cursor_position()
	)
end

vim.o.statusline = "%!v:lua.require'config.statusline'.compose()"

return M
