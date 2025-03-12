return {
 --  "nvim-neotest/neotest",
 --  dependencies = {
 --    "nvim-neotest/nvim-nio",
 --    "nvim-lua/plenary.nvim",
 --    "antoinemadec/FixCursorHold.nvim",
 --    "nvim-treesitter/nvim-treesitter",
	-- 	"lawrence-laz/neotest-zig",
 --  },
	-- config = function()
	-- 	local neotest = require("neotest")
	-- 	neotest.setup {
	-- 		adapters = {
	-- 			require("neotest-zig")({
	-- 				dap = {
	-- 					adapter = "lldb",
	-- 				}
	-- 			}),
	-- 		},
	-- 	}


		-- vim.keymap.set("n", "<localleader>t", neotest.summary.toggle, {silent = true})
	-- 	vim.keymap.set("n", "<leader>t", neotest.summary.toggle, {silent = true})
	-- 	vim.keymap.set("n", "<localleader>r", neotest.run.run, {silent = true})
	-- 	vim.keymap.set("n", "]t", function()
	-- 		neotest.jump.next { status = "failed" }
	-- 		vim.cmd[[normal! zt]]
	-- 	end, {silent = true})
	-- 	vim.keymap.set("n", "[t", function()
	-- 		neotest.jump.prev { status = "failed" }
	-- 		vim.cmd[[normal! zt]]
	-- 	end, {silent = true})
	-- end
}
