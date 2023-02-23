local plugin_manager_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(plugin_manager_path) then
  print("plugins: cloning plugin manager")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    plugin_manager_path,
  })
end
vim.opt.rtp:prepend(plugin_manager_path)

local plugins = {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  "lewis6991/gitsigns.nvim",
  "neovim/nvim-lspconfig",
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    version = "*",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    version = false,
  },
  "nvim-treesitter/nvim-treesitter-context",
  "sainnhe/gruvbox-material",
  "simrat39/rust-tools.nvim",
  "tpope/vim-commentary",
  "tpope/vim-sleuth",
  "windwp/nvim-autopairs",
}

require("lazy").setup(plugins)
