-- Configurations: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md.
-- Language specific plugins: https://github.com/neovim/nvim-lspconfig/wiki/Language-specific-plugins.
local cmp_nvim_lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")
local lspconfig_util = require("lspconfig.util")
local null_ls = require("null-ls")
local rust_tools = require("rust-tools")

local options = { noremap = true, silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, options)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, options)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, options)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, options)

local on_attach = function(_, buffer_number)
  local buffer_options = { noremap = true, silent = true, buffer = buffer_number }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buffer_options)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, buffer_options)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, buffer_options)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buffer_options)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, buffer_options)
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, buffer_options)
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, buffer_options)
  vim.keymap.set("n", "<space>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, buffer_options)
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, buffer_options)
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, buffer_options)
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, buffer_options)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, buffer_options)
  vim.keymap.set("n", "<space>f", function() vim.lsp.buf.format { async = true } end, buffer_options)
end

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
    capabilities = cmp_nvim_lsp_capabilities,
    on_attach = on_attach,
  }
end

-- General language server. See the following for a complete list of
-- configuration options.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
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
  capabilities = cmp_nvim_lsp_capabilities,
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
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    vim.lsp.buf.code_action({
      context = { only = { 'source.organizeImports' } },
      apply = true,
    })
  end,
  pattern = "*.go",
})

lspconfig.lua_ls.setup {
  capabilities = cmp_nvim_lsp_capabilities,
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
rust_tools.setup({
  server = {
    capabilities = cmp_nvim_lsp_capabilities,
    on_attach = on_attach,
  }
})

lspconfig.sourcekit.setup {
  capabilities = cmp_nvim_lsp_capabilities,
  on_attach = on_attach,
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "objective-c", "objective-cpp", "swift" },
  root_dir = lspconfig_util.root_pattern("Package.swift", ".git"),
}
