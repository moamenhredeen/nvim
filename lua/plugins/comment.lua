-- ***********************************************************************
-- configure comment
--

return {
	"numToStr/Comment.nvim",
	config =  function()
		require('Comment').setup {
			padding = true,
			sticky = true,
			ignore = '^$',
			toggler = {
				line = 'gcc',
				block = 'gbc'
			},
			extra = {
				above = 'gck',
				below = 'gcj',
				eol = 'gca',
			},
			--NOTE: If given `false` then the plugin won't create any mappings
			mappings = {
				basic = true,
				extra = true,
			},
		}
	end
}
