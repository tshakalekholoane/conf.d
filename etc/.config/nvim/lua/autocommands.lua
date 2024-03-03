vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  desc     = "Highlight on yank",
  group    = vim.api.nvim_create_augroup("highlight-on-yank", { clear = true }),
  pattern  = "*",
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end
    vim.cmd.update()
  end,
  desc     = "Autosave",
  group    = vim.api.nvim_create_augroup("autosave", { clear = true }),
  pattern  = "*",
})
