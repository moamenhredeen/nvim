return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "echasnovski/mini.pick",
  },
  lazy = true,
  keys = {
	  {'<leader>g', ':Neogit kind=split<CR>', 'toggle neogit'}
  },
  config = function ()
	  local neogit = require('neogit')
	  neogit.setup()
  end
};
