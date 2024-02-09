local palette = {
  cantaloupe = "#ffd479",
  carnation  = "#ff8ad8",
  charcoal   = "#1d1d1d",
  ice        = "#73fdff",
  jet        = "#363636",
  lead       = "#212121",
  liquorice  = "#161617",
  salmon     = "#ff7e79",
  sky        = "#76d6ff",
  snow       = "#ffffff",
  spindrift  = "#73fcd6",
  steel      = "#929292",
  strawberry = "#ff2f92",
  tangerine  = "#ff9300",
  tungsten   = "#424242",
}

local groups = {
  -- See group-name in syntax.
  Comment                  = { fg = palette.steel },
  Constant                 = { fg = palette.spindrift },
  Delimiter                = { fg = palette.steel },
  Function                 = { bold = true, fg = palette.snow },
  Identifier               = { fg = palette.snow },
  Operator                 = { fg = palette.cantaloupe },
  PreProc                  = { fg = palette.sky },
  Special                  = {},
  Statement                = { fg = palette.sky },
  Todo                     = { bold = true },
  Type                     = { fg = palette.salmon },
  Underlined               = { underline = true },

  -- See highlight-groups.
  ColorColumn              = { bg = palette.lead },
  DiagnosticError          = { fg = palette.salmon },
  DiagnosticUnderlineError = { sp = palette.salmon },
  DiagnosticUnderlineWarn  = { sp = palette.salmon },
  DiagnosticWarn           = { fg = palette.cantaloupe },
  DiffAdd                  = { fg = palette.spindrift },
  DiffChange               = { fg = palette.cantaloupe },
  DiffDelete               = { fg = palette.salmon },
  DiffText                 = {},
  ErrorMsg                 = { fg = palette.salmon },
  Folded                   = { bg = palette.lead, fg = palette.steel },
  IncSearch                = { bg = palette.jet, bold = true },
  LineNr                   = { fg = palette.steel },
  MatchParen               = { fg = palette.strawberry },
  MoreMsg                  = {},
  NonText                  = { fg = palette.tungsten },
  Normal                   = { bg = palette.charcoal, fg = palette.snow },
  Pmenu                    = { bg = palette.liquorice, fg = palette.snow },
  PmenuSel                 = { bg = palette.jet, bold = true },
  Question                 = {},
  SignColumn               = { bg = palette.charcoal },
  SpellBad                 = { sp = palette.salmon, underline = true },
  SpellCap                 = { sp = palette.sky, underline = true },
  SpellLocal               = { sp = palette.salmon, underline = true },
  StatusLine               = { bg = palette.liquorice, fg = palette.snow },
  Title                    = { fg = palette.snow, bold = true },
  Visual                   = { bg = palette.jet, bold = true },
  WarningMsg               = { fg = palette.cantaloupe },
}

local terminal = {
  [0] = palette.charcoal,
  [1] = palette.salmon,
  [2] = palette.spindrift,
  [3] = palette.cantaloupe,
  [4] = palette.sky,
  [5] = palette.carnation,
  [6] = palette.ice,
  [7] = palette.snow,
}

vim.opt.background = "dark"
vim.cmd.highlight("clear")
vim.cmd.syntax("reset")
vim.g.colors_name = "ragnar"

for k, v in pairs(terminal) do
  vim.g["terminal_color_" .. k] = v
  vim.g["terminal_color_" .. k + 8] = v
end

for k, v in pairs(groups) do
  vim.api.nvim_set_hl(0, k, v)
end
