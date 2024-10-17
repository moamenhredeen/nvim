-- local luasnip = require('luasnip')
-- require("luasnip.loaders.from_vscode").lazy_load()

return {
	'L3MON4D3/LuaSnip',
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	config = function()
		-- local ls = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		-- vim.keymap.set({ "i" }, "<C-K>", function() ls.expand() end, { silent = true })
		-- vim.keymap.set({ "i", "s", "n" }, "<C-L>", function() ls.jump(1) end, { silent = true })
		-- vim.keymap.set({ "i", "s", "n" }, "<C-J>", function() ls.jump(-1) end, { silent = true })
	end
}
