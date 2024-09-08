local function format_file()
  vim.cmd(":silent !swiftformat '%'")
end

vim.keymap.set("n", "<space>f", format_file)
vim.opt.commentstring = "// %s"
