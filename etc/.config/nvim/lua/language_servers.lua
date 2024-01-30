local completions = require "cmp_nvim_lsp"
local configuration = require "lspconfig"
local general = require "null-ls"
local utilities = require "lspconfig.util"

vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

local function list_workspace_folders()
  print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end

local function async_buf_format()
  vim.lsp.buf.format { async = true }
end

local function on_attach(_, buffer)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "[g]o to [D]eclaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "[g]o to [d]efinition" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer, desc = "[g]o to [i]mplementation" })
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Signature help" })
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
    { buffer = buffer, desc = "[w]orkspace [a]dd folder" })
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
    { buffer = buffer, desc = "[w]orkspace [r]emove folder" })
  vim.keymap.set("n", "<space>wl", list_workspace_folders, { buffer = buffer, desc = "[W]orkspace [L]ist folders" })
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = buffer, desc = "Type definition" })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "[r]e[n]ame" })
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "[c]ode [a]ction" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buffer, desc = "[g]o to [r]eferences" })
  vim.keymap.set("n", "<space>f", async_buf_format, { buffer = buffer, desc = "Format" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
completions.default_capabilities(capabilities)


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
  configuration[server].setup {
    capabilities = capabilities,
    on_attach = on_attach,
  }
end

-- General language server. See the following for a complete list of
-- configuration options.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
general.setup({
  sources = {
    general.builtins.code_actions.gomodifytags,
    general.builtins.diagnostics.actionlint,
    general.builtins.diagnostics.buildifier,
    general.builtins.diagnostics.checkmake,
    general.builtins.diagnostics.fish,
    general.builtins.diagnostics.swiftlint,
    general.builtins.formatting.buildifier,
    general.builtins.formatting.fish_indent,
    general.builtins.formatting.goimports,
    general.builtins.formatting.jq,
    general.builtins.formatting.swiftformat,
    general.builtins.formatting.swiftlint,
    general.builtins.formatting.trim_whitespace,
    general.builtins.formatting.yamlfmt,
  },
})

configuration.gopls.setup {
  capabilities = capabilities,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  on_attach = on_attach,
  root_dir = utilities.root_pattern("go.work", "go.mod", ".git"),
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
      context = { only = { "source.organizeImports" } },
      apply = true,
    })
  end,
  pattern = "*.go",
})

configuration.lua_ls.setup {
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

configuration.sourcekit.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = { "xcrun", "sourcekit-lsp" },
  filetypes = { "objective-c", "objective-cpp", "swift" },
  root_dir = utilities.root_pattern("Package.swift", ".git"),
})

vim.g.rustaceanvim = {
  tools = {},
  server = {
    on_attach = on_attach,
    settings = {
      ["rust-analyzer"] = {},
    },
  },
  dap = {},
}
