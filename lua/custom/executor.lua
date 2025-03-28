---@type integer | nil
local last_win_id = nil

---@type integer | nil
local last_buf_id = nil

local win_config = {
	split = "below",
	height = 20,
}

local M = {}

---@return boolean
function M._is_windows()
	local sysname = vim.uv.os_uname().sysname
	return sysname == 'Windows' or sysname == 'Windows_NT'
end

---@return boolean
function M._is_macos()
	return vim.uv.os_uname().sysname == 'Darwin'
end

---@param bufnr integer | nil
function M._delete_buf(bufnr)
	if bufnr ~= nil and vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_delete(bufnr, { force = true })
	end
end

---@param winnr integer | nil
function M._close_win(winnr)
	if winnr ~= nil and vim.api.nvim_win_is_valid(winnr) then
		vim.api.nvim_win_close(winnr, true)
	end
end


-- @param command to execute
function M.execute_command(command)

	local prev_win_id = vim.api.nvim_get_current_win()

	if last_win_id and vim.api.nvim_win_is_valid(last_win_id) then
		vim.api.nvim_win_close(last_win_id, true)
	end

	if last_buf_id and vim.api.nvim_buf_is_valid(last_buf_id) then
		vim.api.nvim_buf_delete(last_buf_id, {})
	end

	last_buf_id = vim.api.nvim_create_buf(false, true)
	last_win_id = vim.api.nvim_open_win(last_buf_id, true, win_config)

	-- hide the cursor that apears at the end of the output
	vim.api.nvim_create_autocmd("TermOpen", {
		buffer = last_buf_id,
		callback = function ()
    	vim.cmd("highlight! Cursor guibg=NONE guifg=NONE gui=NONE")
		end
	})
	vim.fn.termopen(command)
	vim.api.nvim_set_current_win(prev_win_id)


	-- previously i used jobstart and piped the output to a regular buffer (idk why)
	-- run the command
	-- vim.api.nvim_buf_set_lines(latest_buf_id, 0, -1, false, {})
	-- vim.fn.jobstart(command, {
	-- 	stdout_buffered = true,
	-- 	stderr_buffered = true,
	-- 	on_stdout = function (_, data)
	-- 		if not data then
	-- 			return
	-- 		end
	-- 		vim.schedule(function ()
	-- 			vim.api.nvim_buf_set_lines(latest_buf_id, -1, -1, false, data)
	-- 			vim.api.nvim_win_set_cursor(latest_win_id, {vim.api.nvim_buf_line_count(latest_buf_id), 0})
	-- 		end)
	-- 	end,
	-- 	on_stderr = function (_, data)
	-- 		if not data then
	-- 			return
	-- 		end
	-- 		vim.schedule(function ()
	-- 			vim.api.nvim_buf_set_lines(latest_buf_id, -1, -1, false, data)
	-- 			vim.api.nvim_win_set_cursor(latest_win_id, {vim.api.nvim_buf_line_count(latest_buf_id), 0})
	-- 		end)
	-- 	end
	-- })

	-- hide the buffer when escape s pressed :)
	vim.keymap.set('n', '<Esc>', '<CMD>hide<CR>', { buffer = last_buf_id, noremap = true })
	vim.keymap.set('n', 'q', '<CMD>hide<CR>', { buffer = last_buf_id, noremap = true })
end

return M
