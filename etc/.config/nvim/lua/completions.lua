local autopairs     = require "nvim-autopairs.completion.cmp"
local completions   = require "cmp"
local loaders       = require "luasnip.loaders.from_vscode"
local snippets      = require "luasnip"

local configuration = {
  snippet = {
    expand = function(args)
      snippets.lsp_expand(args.body)
    end,
  },
  mapping = completions.mapping.preset.insert {
    ["<C-d>"]     = completions.mapping.scroll_docs(-4),
    ["<C-f>"]     = completions.mapping.scroll_docs(4),
    ["<C-Space>"] = completions.mapping.complete {},
    ["<CR>"]      = completions.mapping.confirm {
      behavior = completions.ConfirmBehavior.Replace,
      select   = true,
    },
    ["<Tab>"]     = completions.mapping(function(fallback)
      if completions.visible() then
        completions.select_next_item()
      elseif snippets.expand_or_jumpable() then
        snippets.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"]   = completions.mapping(function(fallback)
      if completions.visible() then
        completions.select_prev_item()
      elseif snippets.jumpable(-1) then
        snippets.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
}

loaders.lazy_load()
snippets.config.setup()
completions.event:on("confirm_done", autopairs.on_confirm_done())
completions.setup(configuration)
