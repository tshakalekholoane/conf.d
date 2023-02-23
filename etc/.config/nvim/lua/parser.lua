local options = {
  auto_install = true,
  autotag = { enable = true },
  ensure_installed = {
    -- See the following for a complete list.
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages.
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "fish",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "help",
    "html",
    "javascript",
    "json",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "sql",
    "swift",
    "toml",
    "vim",
    "yaml",
  },
  endwise = { enable = true },
  highlight = { enable = true, },
  indent = { enable = true, disable = { "python" } },
}

require("nvim-treesitter.configs").setup(options)
require("treesitter-context").setup {}
