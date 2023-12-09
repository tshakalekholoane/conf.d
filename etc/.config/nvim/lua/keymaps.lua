local function toggle_background()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end

vim.keymap.set("n", "<Leader>a", "1<C-a>")
vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<Leader>o", ":only<CR>")
vim.keymap.set("n", "<Leader>r", "<Esc>:edit<CR>")
vim.keymap.set("n", "<Leader>s", "<Esc>:r! x_snip ")
vim.keymap.set("n", "<Leader>t", toggle_background)
vim.keymap.set("n", "<Leader>w", "<Esc>:write<CR>")
vim.keymap.set("n", "Q", "<Nop>")
