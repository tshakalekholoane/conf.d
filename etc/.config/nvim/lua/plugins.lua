local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local bootstrapped = vim.loop.fs_stat(path)
if not bootstrapped then
  print("plugins: cloning plugin manager")
  vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", path })
  vim.cmd.packadd("packer.nvim")
end

local plugins = {
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  },
  "lewis6991/gitsigns.nvim",
  "neovim/nvim-lspconfig",
  "nordtheme/vim",
  {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && " ..
        "cmake --build build --config Release && cmake --install build --prefix build"
  },
  {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    requires = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  "nvim-treesitter/nvim-treesitter-context",
  "sainnhe/gruvbox-material",
  "simrat39/rust-tools.nvim",
  "tpope/vim-commentary",
  "tpope/vim-sleuth",
  "wbthomason/packer.nvim",
  "windwp/nvim-autopairs",
}

local packer = require("packer")
packer.startup({
  function(use)
    for _, plugin in ipairs(plugins) do
      use(plugin)
    end

    if not bootstrapped then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float()
      end,
    },
  },
})
