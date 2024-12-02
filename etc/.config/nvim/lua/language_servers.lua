local configuration = require "lspconfig"
local utilities     = require "lspconfig.util"

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
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, { buffer = buffer, desc = "Signature help" })
  vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, { buffer = buffer, desc = "Type definition" })
  vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = buffer, desc = "[c]ode [a]ction" })
  vim.keymap.set("n", "<space>f", async_buf_format, { buffer = buffer, desc = "Format" })
  vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, { buffer = buffer, desc = "[r]e[n]ame" })
  vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder,
    { buffer = buffer, desc = "[w]orkspace [a]dd folder" })
  vim.keymap.set("n", "<space>wl", list_workspace_folders, { buffer = buffer, desc = "[W]orkspace [L]ist folders" })
  vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder,
    { buffer = buffer, desc = "[w]orkspace [r]emove folder" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = buffer, desc = "Hover" })
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = buffer, desc = "[g]o to [D]eclaration" })
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = buffer, desc = "[g]o to [d]efinition" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = buffer, desc = "[g]o to [i]mplementation" })
  vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = buffer, desc = "[g]o to [r]eferences" })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Servers configured with their default settings.
local servers = {
  "clangd",
  "cssls",
  "denols",
  "golangci_lint_ls",
  "html",
  "pyright",
  "ruff",
  "sourcekit",
}
for _, server in ipairs(servers) do
  configuration[server].setup {
    capabilities = capabilities,
    on_attach    = on_attach,
  }
end

configuration.gopls.setup({
  capabilities        = capabilities,
  cmd                 = { "gopls", "serve" },
  filetypes           = { "go", "gomod", "gowork", "gotmpl" },
  on_attach           = on_attach,
  root_dir            = utilities.root_pattern("go.work", "go.mod", ".git"),
  single_file_support = true,
  settings            = {
    gopls = {
      analyses    = {
        fieldalignment = true,
        nilness        = true,
        shadow         = true,
        unusedparams   = true,
        unusedvariable = true,
        unusedwrite    = true,
        useany         = true,
      },
      gofumpt     = true,
      staticcheck = true,
      vulncheck   = "Imports",
    },
  },
})

configuration.lua_ls.setup({
  capabilities = capabilities,
  on_attach    = on_attach,
  settings     = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      format      = { enable = true },
      runtime     = { version = "LuaJIT" },
      telemetry   = { enable = false },
      workspace   = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
})

vim.g.rustaceanvim = {
  dap    = {},
  server = {
    on_attach = on_attach,
    settings  = { ["rust-analyzer"] = {} },
  },
  tools  = {},
}
