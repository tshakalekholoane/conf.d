-- Keymaps.
local function toggle_background()
  vim.o.background = vim.o.background == "dark" and "light" or "dark"
end
vim.keymap.set("n", "<Leader>e", vim.cmd.Ex)
vim.keymap.set("n", "<Leader>o", ":only<CR>")
vim.keymap.set("n", "<Leader>r", "<Esc>:edit<CR>")
vim.keymap.set("n", "<Leader>t", toggle_background)
vim.keymap.set("n", "<Leader>w", "<Esc>:write<CR>")
vim.keymap.set("n", "Q", "<Nop>")
vim.keymap.set("n", "<Leader>a", "1<C-a>")

-- Options.
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
vim.opt.list = true
vim.opt.listchars = { tab = "➔ ", trail = "·" }
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
local autosave_group = vim.api.nvim_create_augroup("AutoSave", { clear = true })
vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.bo.buftype ~= "" then
      return
    end
    vim.cmd.update()
  end,
  group = autosave_group,
  pattern = "*",
})

-- Status line.
function current_branch()
  if vim.b.git_branch ~= nil then
    return vim.b.git_branch
  end
  local current = vim.fn.system("git branch --show-current 2> /dev/null")
  vim.b.git_branch = current ~= "" and current:gsub("\n", "") or ""
  return vim.b.git_branch
end

local current_branch_group = vim.api.nvim_create_augroup("CurrentBranch", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter", "WinEnter" }, {
  callback = current_branch,
  group = current_branch_group,
})

local mantle = "#292c3c"
local lavender = "#babbf1"
local green = "#a6d189"
local flamingo = "#eebebe"
local sky = "#99d1db"
local palette = { sky, green, lavender, flamingo }
for index, colour in ipairs(palette) do
  local options = { "User" .. index, "guibg=" .. colour, "guifg=" .. mantle }
  vim.cmd.highlight(options)
end

function current_mode()
  local prefix = vim.fn.mode():sub(1, 1):lower()
  if prefix == "i" then
    return "%2* INS %*"
  elseif prefix == "n" then
    return "%3* NOR %*"
  elseif prefix == "r" then
    return "%1* REP %*"
  elseif prefix == "v" then
    return "%4* VIS %*"
  else
    return ""
  end
end

vim.opt.showmode = false
vim.opt.statusline = "%{%v:lua.current_mode()%} %-F %m %-r %= %{%v:lua.current_branch()%}  %l,%c %p%%  %y"

-- Plugins.
local path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(path) then
  print("plugins: cloning plugin manager")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    path,
  })
end
vim.opt.rtp:prepend(path)
local plugins = {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
  },
  { "folke/neodev.nvim",    opts = {} },
  { "folke/which-key.nvim", opts = {} },
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "lewis6991/gitsigns.nvim", opts = {} },
  "neovim/nvim-lspconfig",
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
  },
  "nvim-treesitter/nvim-treesitter-context",
  "simrat39/rust-tools.nvim",
  "tpope/vim-commentary",
  "tpope/vim-sleuth",
  { "windwp/nvim-autopairs",   event = "InsertEnter", opts = {} },
}
require("lazy").setup(plugins, {})

-- Colour scheme.
require("catppuccin").setup({
  flavour = "frappe",
  term_colors = true,
  no_italic = true,
})
vim.cmd.colorscheme("catppuccin")

-- Finder.
local telescope = require("telescope")
telescope.setup {
  pickers = {
    find_files = {
      find_command = {
        "fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git",
      },
    },
  },
}
pcall(telescope.load_extension, "fzf")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local function find_in_file()
  telescope_builtin.current_buffer_fuzzy_find(telescope_themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end
vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, { desc = "[f]ind [b]uffers" })
vim.keymap.set("n", "<leader>fc", find_in_file, { desc = "Find in file" })
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, { desc = "[f]ind [f]ile" })
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, { desc = "[f]ile [g]rep" })
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, { desc = "[f]ind in [h]elp" })
vim.keymap.set("n", "gr", telescope_builtin.lsp_references, { desc = "List references" })

-- Parser.
vim.defer_fn(function()
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
      "gowork",
      "gpg",
      "html",
      "java",
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
      "vimdoc",
      "yaml",
    },
    endwise = { enable = true },
    highlight = { enable = true, },
    indent = { enable = true, disable = { "python" } },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<c-Space>",
        node_incremental = "<c-Space>",
        scope_incremental = "<c-s>",
        node_decremental = "<M-Space>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
      swap = {
        enable = true,
        swap_next = { ["<Leader>a"] = "@parameter.inner" },
        swap_previous = { ["<Leader>A"] = "@parameter.inner" },
      },
    },
  }
  require("nvim-treesitter.configs").setup(options)
end, 0)

-- Language servers.
-- Configurations: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md.
-- Language specific plugins: https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins.

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

local on_attach = function(_, buffer)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "[g]o to [D]eclaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "[g]o to [d]efinition" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer, desc = "[g]o to [i]mplementation" })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Signature help" })
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
    { buffer = buffer, desc = "[w]orkspace [a]dd folder" })
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
    { buffer = buffer, desc = "[w]orkspace [r]emove folder" })
  vim.keymap.set("n", "<space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
    { buffer = buffer, desc = "[W]orkspace [L]ist folders" })
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = buffer, desc = "Type definition" })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "[r]e[n]ame" })
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "[c]ode [a]ction" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buffer, desc = "[g]o to [r]eferences" })
  vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end,
    { buffer = buffer, desc = "Format" })
end

local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Servers configured with their default settings.
local servers = {
  "bashls",
  "clangd",
  "cssls",
  "denols",
  "golangci_lint_ls",
  "html",
  "jsonls",
  "pyright",
  "ruff_lsp",
}
for _, server in ipairs(servers) do
  lspconfig[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- General language server. See the following for a complete list of
-- configuration options.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.code_actions.gomodifytags,
    null_ls.builtins.diagnostics.actionlint,
    null_ls.builtins.diagnostics.buildifier,
    null_ls.builtins.diagnostics.checkmake,
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.diagnostics.flake8,
    null_ls.builtins.diagnostics.swiftlint,
    null_ls.builtins.formatting.buildifier,
    null_ls.builtins.formatting.fish_indent,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.jq,
    null_ls.builtins.formatting.swiftformat,
    null_ls.builtins.formatting.swiftlint,
    null_ls.builtins.formatting.trim_whitespace,
    null_ls.builtins.formatting.yamlfmt,
  },
})

lspconfig.gopls.setup {
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  on_attach = on_attach,
  root_dir = lspconfig_util.root_pattern("go.work", "go.mod", ".git"),
  single_file_support = true,
  settings = {
    gopls = {
      analyses = {
        fieldalignment = true,
        nilness = true,
        shadow = true,
        unusedparams = true,
        unusedwrite = true,
        useany = true,
        unusedvariable = true,
      },
      gofumpt = true,
      staticcheck = true,
    },
  },
}

-- Organise imports in Go on save. See the following for reference:
-- https://github.com/golang/tools/blob/master/gopls/doc/vim.md#neovim-imports.
local go_organise_imports_group = vim.api.nvim_create_augroup("GoOrganiseImports", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end,
  group = go_organise_imports_group,
  pattern = "*.go",
})

lspconfig.lua_ls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      format = { enable = true },
      runtime = { version = "LuaJIT" },
      telemetry = { enable = false },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
}

-- rust-tools.nvim embeds rust-analyzer and requires a slightly
-- different configuration.
require("rust-tools").setup({
  server = {
    capabilities = capabilities,
    on_attach = on_attach,
  }
})

lspconfig.sourcekit.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "objective-c", "objective-cpp", "swift" },
  root_dir = lspconfig_util.root_pattern("Package.swift", ".git"),
}

-- Completions.
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()
luasnip.config.setup()

local completions = require("cmp")
completions.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = completions.mapping.preset.insert {
    ["<C-d>"] = completions.mapping.scroll_docs(-4),
    ["<C-f>"] = completions.mapping.scroll_docs(4),
    ["<C-Space>"] = completions.mapping.complete {},
    ["<CR>"] = completions.mapping.confirm {
      behavior = completions.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = completions.mapping(function(fallback)
      if completions.visible() then
        completions.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = completions.mapping(function(fallback)
      if completions.visible() then
        completions.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
})

local autopairs_completion = require("nvim-autopairs.completion.cmp")
completions.event:on("confirm_done", autopairs_completion.on_confirm_done())
