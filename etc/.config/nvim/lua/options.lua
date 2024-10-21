vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
    },
  },
})
vim.diagnostic.enable(false)
vim.g.netrw_banner           = 0
vim.g.netrw_liststyle        = 3
vim.g.rust_recommended_style = 0
vim.g.rustfmt_autosave       = 1
vim.opt.breakindent          = true
vim.opt.clipboard            = "unnamedplus"
vim.opt.cmdheight            = 0
vim.opt.colorcolumn          = "72,80"
vim.opt.completeopt          = { "menuone", "noselect" }
vim.opt.cursorline           = true
vim.opt.encoding             = "utf-8"
vim.opt.foldenable           = false
vim.opt.foldexpr             = "nvim_treesitter#foldexpr()"
vim.opt.foldmethod           = "expr"
vim.opt.hlsearch             = false
vim.opt.ignorecase           = true
vim.opt.inccommand           = "split"
vim.opt.incsearch            = true
vim.opt.laststatus           = 3
vim.opt.list                 = true
vim.opt.listchars            = { tab = "➔ ", trail = "·" }
vim.opt.mouse                = "a"
vim.opt.mousescroll          = "ver:3,hor:0"
vim.opt.number               = true
vim.opt.relativenumber       = true
vim.opt.scrolloff            = 8
vim.opt.shiftwidth           = 2
vim.opt.showmode             = false
vim.opt.smartcase            = true
vim.opt.spelllang            = "en_gb"
vim.opt.spelloptions         = "camel"
vim.opt.splitbelow           = true
vim.opt.splitright           = true
vim.opt.syntax               = "on"
vim.opt.tabstop              = 2
vim.opt.undofile             = true
vim.opt.updatetime           = 1000
vim.opt.wrap                 = false
