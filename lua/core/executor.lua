---@type integer | nil
local latest_buf_id = nil

local M = {}

---@return boolean
function M.is_windows()
  local sysname = vim.uv.os_uname().sysname
  return sysname == 'Windows' or sysname == 'Windows_NT'
end

---@return boolean
function M.is_macos()
  return vim.uv.os_uname().sysname == 'Darwin'
end

---@return boolean
local function is_nushell()
  ---@diagnostic disable-next-line: missing-parameter
  local shell = vim.uv.os_getenv('SHELL')
  local nu = 'nu'
  -- Check if $SHELL ends in "nu"
  return shell ~= nil and shell:sub(-string.len(nu)) == nu
end

---Get a new command which is a chain of all the old commands
---Note that a space is not added at the end of the returned command string
---@param commands string[]
---@return string
function M.chain_commands(commands)
  local separator = M.is_windows() and ' | ' or is_nushell() and ';' or ' && '
  local ret = ''

  for i, value in ipairs(commands) do
    local is_last = i == #commands
    ret = ret .. value

    if not is_last then
      ret = ret .. separator
    end
  end
  return ret
end

---Create a `cd` command for the path
---@param path string
---@return string
function M.make_cd_command(path)
  return ('cd "%s"'):format(path)
end

---@param command string
---@param args string[]
---@return string command
function M.make_command_from_args(command, args)
  local ret = command .. ' '

  for _, value in ipairs(args) do
    ret = ret .. value .. ' '
  end

  return ret
end

---@param bufnr integer | nil
function M.delete_buf(bufnr)
  if bufnr ~= nil and vim.api.nvim_buf_is_valid(bufnr) then
    vim.api.nvim_buf_delete(bufnr, { force = true })
  end
end

---@param winnr integer | nil
function M.close_win(winnr)
  if winnr ~= nil and vim.api.nvim_win_is_valid(winnr) then
    vim.api.nvim_win_close(winnr, true)
  end
end

---@param vertical boolean
---@param bufnr integer
function M.split(vertical, bufnr)
  local cmd = vertical and 'vsplit' or 'split'

  vim.cmd(cmd)
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, bufnr)
end

---@param vertical boolean
---@param amount string
function M.resize(vertical, amount)
  local cmd = vertical and 'vertical resize ' or 'resize'
  cmd = cmd .. amount

  vim.cmd(cmd)
end

---@param command  string
---@param args string[]
---@param cwd string | nil
function M.execute_command(command, args, cwd, _)
	local commands = {}
	if cwd then
		table.insert(commands, M.make_cd_command(cwd))
	end
	table.insert(commands, M.make_command_from_args(command, args))
	local full_command = M.chain_commands(commands)

	-- check if a buffer with the latest id is already open, if it is then
	-- delete it and continue
	M.delete_buf(latest_buf_id)

	-- create the new buffer
	latest_buf_id = vim.api.nvim_create_buf(false, true)

	-- split the window to create a new buffer and set it to our window
	M.split(false, latest_buf_id)

	-- make the new buffer smaller
	M.resize(false, '-5')

	-- close the buffer when escape is pressed :)
	vim.keymap.set('n', '<Esc>', '<CMD>q<CR>', { buffer = latest_buf_id, noremap = true })

	-- run the command
	vim.fn.termopen(full_command)

	-- when the buffer is closed, set the latest buf id to nil else there are
	-- some edge cases with the id being sit but a buffer not being open
	local function onDetach(_, _)
		latest_buf_id = nil
	end
	vim.api.nvim_buf_attach(latest_buf_id, false, { on_detach = onDetach })
end


return M
