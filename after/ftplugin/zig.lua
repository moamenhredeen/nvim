
local executor = require('custom.executor')
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local sorters = require("telescope.sorters")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local last_command = nil

local pick_zig_command = function()
	local current_file = vim.fn.expand("%:.")
	pickers.new({}, {
		prompt_title = "Zig Commands",
		-- finder = finders.new_table(zig_commands),
		finder = finders.new_dynamic({
			fn = function ()
				local commands = {
					"zig build run",
					"zig build test",
					"zig help",
					"zig version",
					"zig run " .. current_file,
					"zig test " .. current_file,
				}
				return commands
			end
		}),
		sorter = sorters.get_generic_fuzzy_sorter({}),
		attach_mappings = function(prompt_bufnr, map)
			local run_command = function()
				action_state.get_current_picker(prompt_bufnr)
				local command = action_state.get_selected_entry()
				if not command or not command[1] then
					return
				end
				actions.close(prompt_bufnr)
				last_command = command[1]
				executor.execute_command(last_command)
			end
			map("i", "<CR>", run_command)
			map("n", "<CR>", run_command)
			return true
		end,
	}):find()
end


local rerun_last_command = function()
	if last_command then
		executor.execute_command(last_command)
	else
		pick_zig_command()
	end
end


vim.keymap.set("n", "<localleader>t", pick_zig_command, {silent = true})
vim.keymap.set("n", "<localleader>r", rerun_last_command, {silent = true})


