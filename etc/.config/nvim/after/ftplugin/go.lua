vim.api.nvim_create_autocmd("BufWritePre", {
 callback = function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply   = true,
  })
  end,
  desc     = "Organise imports in Go",
  group    = vim.api.nvim_create_augroup("go-organise-imports", { clear = true }),
  pattern  = "*.go",
})
