vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  command = "set textwidth=72",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "swift" },
  command = "set commentstring=// %s",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "fish",
  command = [[set commentstring=#\ %s]],
})
