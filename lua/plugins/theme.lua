return {
 "neanias/everforest-nvim",
  version = false,
  lazy = false,
  priority = 1000,
  config = function ()
	  vim.o.background = "dark"
	  vim.cmd[[colorscheme everforest]]
  end
}
