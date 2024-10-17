
local _M = {}

_M.trim_trailing_whitespaces = function()
	-- Save cursor position to restore later
	local curpos = vim.api.nvim_win_get_cursor(0)
	-- Search and replace trailing whitespaces
	vim.cmd([[keeppatterns %s/\s\+$//e]])
	vim.api.nvim_win_set_cursor(0, curpos)
end

return _M
