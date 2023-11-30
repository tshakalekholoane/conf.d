local colour_scheme = require "catppuccin"

local configuration = {
  flavour = "frappe",
  no_italic = true,
  term_colors = true,
}
colour_scheme.setup(configuration)
vim.cmd.colorscheme("catppuccin")
