-- tmux direction
local nvim_to_tmux_directions = {
	['p'] = 'l',
	['h'] = 'L',
	['j'] = 'D',
	['k'] = 'U',
	['l'] = 'R',
	['w'] = 't:.+',
}

local go_to_tmux_pane = function(direction)
	return vim.system({ "tmux", "select-pane", '-' .. nvim_to_tmux_directions[direction] })
end

local has_tmux_control = true

local nvim_navigate = function(direction)
	vim.cmd.wincmd(direction)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), 'n', false)
end

local tmux_nvim_navigate = function(direction)
	vim.print(direction)
	if direction == 'p' then
		-- if the last pane was a tmux pane, then we need to hand control over to tmux;
		-- otherwise, just issue a last pane command in vim
		-- vim.print(has_tmux_control)
		if has_tmux_control then
			go_to_tmux_pane(direction)
		else
			nvim_navigate(direction)
		end
	else
		-- save the current window number to check later whether we're in the same
		-- window after issuing a vim navigation command
		local winnr = vim.fn.winnr()

		-- try to navigate normally
		nvim_navigate(direction)

		-- if we're in the same window after navigating
		-- we are at the edge of vim, we have to hande control over to tmux
		if winnr == vim.fn.winnr() then
			go_to_tmux_pane(direction)
			has_tmux_control = true
		else
			has_tmux_control = false
		end
	end
end



-- if in tmux, map to vim-tmux navigation, otherwise just map to vim navigation
local navigate = nil
if vim.env.TMUX ~= nil then
	navigate = tmux_nvim_navigate
else
	navigate = nvim_navigate
end

for key, value in pairs({
	TmuxNvimNavigateLeft = "h",
	TmuxNvimNavigateDown = "j",
	TmuxNvimNavigateUp = "k",
	TmuxNvimNavigateRight = "l",
	TmuxNvimNavigateLastActive = "p",
	TmuxNvimNavigateNext = 'n'
}) do
	vim.api.nvim_create_user_command(key, function() navigate(value) end, {})
end


local M = {}

function M.TmuxNvimNavigateLeft()
	navigate('h')
end

function M.TmuxNvimNavigateDown()
	navigate('j')
end

function M.TmuxNvimNavigateUp()
	navigate('k')
end

function M.TmuxNvimNavigateRight()
	navigate('l')
end

function M.TmuxNvimNavigateLastActive()
	navigate('p')
end

function M.TmuxNvimNavigateNext()
	navigate('n')
end

return M
