-- return {
-- 	"neanias/everforest-nvim",
-- 	version = false,
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.o.background = "light"
-- 		vim.cmd [[colorscheme everforest]]
-- 	end,
-- }


-- return {
-- 	"miikanissi/modus-themes.nvim",
-- 	priority = 1000,
-- 	config = function()
-- 		vim.o.background = "light"
-- 		vim.cmd [[colorscheme modus_operandi]]
-- 	end,
-- }

-- return {
-- 	"zenbones-theme/zenbones.nvim",
-- 	lazy = false,
-- 	priority = 1000,
-- 	config = function()
-- 		vim.g.zenbones_compat = 1
-- 		vim.o.background = "light"
-- 		vim.cmd.colorscheme('zenbones')
-- 	end
-- }

return {
	'projekt0n/github-nvim-theme',
	name = 'github-theme',
	lazy = false,
	priority = 1000,
	config = function()
		require('github-theme').setup()
		vim.cmd('colorscheme github_light')
	end,
}
