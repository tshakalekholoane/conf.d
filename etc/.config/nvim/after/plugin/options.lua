vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.rust_recommended_style = 0
vim.g.rustfmt_autosave = 1
vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 0
vim.opt.colorcolumn = "72,80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.encoding = "utf-8"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.laststatus = 3
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.shiftwidth = 2
vim.opt.smartcase = true
vim.opt.spell = true
vim.opt.spelllang = "en_gb"
vim.opt.spelloptions = "camel"
vim.opt.syntax = "on"
vim.opt.tabstop = 2
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 1000
vim.opt.wrap = false

-- Highlighted yank.
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Autosave.
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end
    vim.cmd.update()
  end,
  pattern = "*",
})
