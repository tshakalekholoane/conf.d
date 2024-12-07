local configuration = require "nvim-treesitter.configs"

local options = {
  auto_install          = true,
  autotag               = { enable = true },
  ensure_installed      = {
    -- See the following for a complete list.
    -- https://github.com/nvim-treesitter/nvim-treesitter#supported-languages.
    "asm",
    "bash",
    "c",
    "comment",
    "cpp",
    "css",
    "diff",
    "fish",
    "git_config",
    "git_rebase",
    "gitattributes",
    "gitcommit",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "gpg",
    "html",
    "json",
    "jsonc",
    "lua",
    "make",
    "markdown",
    "markdown_inline",
    "nginx",
    "python",
    "rust",
    "sql",
    "swift",
    "toml",
    "vim",
    "vimdoc",
    "yaml",
  },
  endwise               = { enable = true },
  highlight             = { enable = true },
  indent                = { enable = true, disable = { "python" } },
  incremental_selection = {
    enable  = true,
    keymaps = {
      init_selection    = "<c-Space>",
      node_incremental  = "<c-Space>",
      scope_incremental = "<c-s>",
      node_decremental  = "<M-Space>",
    },
  },
  textobjects           = {
    select = {
      enable    = true,
      lookahead = true,
      keymaps   = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move   = {
      enable              = true,
      set_jumps           = true,
      goto_next_start     = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end       = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end   = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
    swap   = {
      enable        = true,
      swap_next     = { ["<Leader>a"] = "@parameter.inner" },
      swap_previous = { ["<Leader>A"] = "@parameter.inner" },
    },
  },
}

local function configure()
  configuration.setup(options)
end

vim.defer_fn(configure, 0)
