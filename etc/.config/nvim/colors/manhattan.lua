local palette = {
  cantaloupe = "#ffd479",
  carnation  = "#ff8ad8",
  charcoal   = "#1d1d1d",
  ice        = "#73fdff",
  jet        = "#363636",
  lavender   = "#d783ff",
  lead       = "#212121",
  liquorice  = "#1a1a1a",
  salmon     = "#ff7e79",
  sky        = "#76d6ff",
  snow       = "#ffffff",
  spindrift  = "#73fcd6",
  steel      = "#929292",
  strawberry = "#ff2f92",
  tangerine  = "#ff9300",
  tungsten   = "#424242",
}

local blended = {
  cantaloupe = "#4a412f",
  lavender   = "#42314a",
  salmon     = "#4a302f",
  spindrift  = "#2e4942",
}

local groups = {
  -- group-name.
  Comment                  = { fg = palette.steel },
  Constant                 = { fg = palette.spindrift },
  String                   = { fg = palette.spindrift },
  Identifier               = { fg = palette.snow },
  Function                 = { bold = true, fg = palette.snow },
  Statement                = { fg = palette.sky },
  Operator                 = { fg = palette.cantaloupe },
  PreProc                  = { fg = palette.sky },
  Type                     = { fg = palette.salmon },
  Special                  = {},
  Tag                      = { bold = true },
  Delimiter                = { fg = palette.steel },
  Underlined               = { fg = palette.sky },
  Todo                     = { bold = true },
  Added                    = { bg = blended.spindrift },
  Changed                  = { bg = blended.cantaloupe },
  Removed                  = { bg = blended.salmon },

  -- highlight-groups.
  ColorColumn              = { bg = palette.lead },
  CurSearch                = { bg = palette.cantaloupe, fg = palette.charcoal, bold = true },
  Cursor                   = { bg = palette.strawberry, fg = palette.charcoal },
  CursorLine               = { bg = palette.lead },
  Directory                = { bold = true },
  DiffAdd                  = { bg = blended.spindrift },
  DiffChange               = { bg = blended.cantaloupe },
  DiffDelete               = { bg = blended.salmon },
  DiffText                 = {},
  ErrorMsg                 = { fg = palette.salmon },
  WinSeparator             = { fg = palette.jet },
  Folded                   = { bg = palette.lead, fg = palette.steel },
  SignColumn               = { bg = palette.charcoal },
  IncSearch                = { bg = palette.cantaloupe, fg = palette.charcoal, bold = true },
  Substitute               = { bg = palette.cantaloupe, fg = palette.charcoal, bold = true },
  LineNr                   = { fg = palette.steel },
  CursorLineNr             = { fg = palette.snow },
  MatchParen               = { fg = palette.strawberry },
  MoreMsg                  = {},
  NonText                  = { fg = palette.tungsten },
  Normal                   = { bg = palette.charcoal, fg = palette.snow },
  NormalFloat              = { bg = palette.liquorice, fg = palette.snow },
  Pmenu                    = { bg = palette.liquorice, fg = palette.snow },
  PmenuSel                 = { bg = palette.jet, bold = true },
  Question                 = {},
  Search                   = { bg = palette.jet, bold = true },
  SpellBad                 = { sp = palette.salmon, underline = true },
  SpellCap                 = { sp = palette.sky, underline = true },
  SpellLocal               = { sp = palette.salmon, underline = true },
  StatusLine               = { bg = palette.liquorice, fg = palette.snow },
  Title                    = { fg = palette.snow, bold = true },
  Visual                   = { bg = palette.jet, bold = true },
  WarningMsg               = { fg = palette.cantaloupe },

  -- diagnostic-highlights.
  DiagnosticError          = { bg = blended.salmon, fg = palette.salmon },
  DiagnosticWarn           = { bg = blended.lavender, fg = palette.lavender },
  DiagnosticHint           = { bg = blended.cantaloupe, fg = palette.cantaloupe },
  DiagnosticUnderlineError = { sp = palette.salmon },
  DiagnosticUnderlineWarn  = { sp = palette.cantaloupe },
  DiagnosticUnderlineHint  = { sp = palette.cantaloupe },

  -- gitsigns-highlight-groups.
  GitSignsAdd              = { fg = palette.spindrift },
  GitSignsChange           = { fg = palette.cantaloupe },
  GitSignsDelete           = { fg = palette.salmon },
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
vim.g.colors_name = "manhattan"

for k, v in pairs(terminal) do
  vim.g["terminal_color_" .. k] = v
  vim.g["terminal_color_" .. k + 8] = v
end

for k, v in pairs(groups) do
  vim.api.nvim_set_hl(0, k, v)
end
