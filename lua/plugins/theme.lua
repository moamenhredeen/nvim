return {
	'projekt0n/github-nvim-theme',
	lazy = false,
	priority = 1000,
	config = function()
		vim.o.background = "light"
		vim.cmd('colorscheme github_light')
	end,
}
