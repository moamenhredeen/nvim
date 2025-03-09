return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require('dap')

		-- debug using leader key
		-- vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint)
		-- vim.keymap.set('n', '<leader>dd', dap.continue)
		-- vim.keymap.set('n', '<leader>dc', dap.run_to_cursor)
		-- vim.keymap.set('n', '<leader>df', dap.step_over)
		-- vim.keymap.set('n', '<leader>db', dap.step_back)
		-- vim.keymap.set('n', '<leader>di', dap.step_into)
		-- vim.keymap.set('n', '<leader>do', dap.step_out)
		-- vim.keymap.set('n', '<leader>de', function()
		-- 	require('dapui').eval(nil, { enter = true })
		-- end)

		-- intellij like keymapping
		vim.keymap.set('n', '<F7>', dap.step_into)
		vim.keymap.set('n', '<F8>', dap.step_over)
		vim.keymap.set('n', '<F9>', dap.continue)

		-- configure dap ui
		local dapui = require("dapui")
		dapui.setup()
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end
	end
}
