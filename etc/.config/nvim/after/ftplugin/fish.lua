local function fish_indent()
  vim.cmd("!fish_indent --write %")
end

vim.keymap.set("n", "<space>f", fish_indent)
vim.opt.commentstring = "# %s"
