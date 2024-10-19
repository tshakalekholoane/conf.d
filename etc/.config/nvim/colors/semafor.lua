-- Name:        Semafor
-- Author:      Tshaka Lekholoane <mail+git@tshaka.dev>
-- Website:     https://github.com/tshakalekholoane/conf.d
-- License:     ISC

local groups = {
  -- See group-name.
  Comment                  = { fg = "#bc4d2c" },
  Constant                 = { fg = "#af2f1b" },
  String                   = { fg = "#af1f1b" },
  Character                = { fg = "#af1f1b" },
  Number                   = { fg = "#af1f1b" },
  Boolean                  = { fg = "#af1f1b" },
  Float                    = { fg = "#af1f1b" },
  Identifier               = { fg = "#1f1d1a" },
  Function                 = { bold = true, fg = "#1f1d1a" },
  Statement                = { fg = "#1f2b6d" },
  Conditional              = { fg = "#1f2b6d" },
  Repeat                   = { fg = "#1f2b6d" },
  Label                    = { fg = "#1f2b6d" },
  Operator                 = { fg = "#1f1d1a" },
  Keyword                  = { fg = "#1f2b6d" },
  Exception                = { fg = "#1f2b6d" },
  PreProc                  = { fg = "#1f2b6d" },
  Include                  = { fg = "#1f2b6d" },
  Define                   = { fg = "#1f2b6d" },
  Macro                    = { fg = "#1f2b6d" },
  PreCondit                = { fg = "#1f2b6d" },
  Type                     = { fg = "#3a6d78" },
  StorageClass             = { fg = "#3a6d78" },
  Structure                = { fg = "#3a6d78" },
  Typedef                  = { fg = "#3a6d78" },
  Special                  = { fg = "#3a6d78" },
  SpecialChar              = { fg = "#3a6d78" },
  Tag                      = { bold = true },
  Delimiter                = { fg = "#1f1d1a" },
  SpecialComment           = { fg = "#1f1d1a" },

  -- TODO: Debug.

  Underlined               = { bg = "#fefaee", fg = "#0e29b5" },
  Ignore                   = { fg = "#b6b49e" },

  -- TODO: Error.

  Todo                     = { bold = true, fg = "#bc4d2c" },
  Added                    = { bg = "#e4e5c8" },
  Removed                  = { bg = "#f0dfc4" },
  Changed                  = { bg = "#f7eec9" },

  -- See highlight-groups.
  ColorColumn              = { bg = "#f3f0d3" },
  Conceal                  = { fg = "#b6b49e" },
  CurSearch                = { bg = "#ffff00", fg = "#1f1d1a", bold = true },
  Cursor                   = { bg = "#3a6d78", fg = "#f8f5d7" },

  -- TODO: lCursor.
  -- TODO: CursorIM.
  -- TODO: CursorColumn.

  CursorLine               = { bg = "#f3f0d3" },

  -- TODO: Directory.

  DiffAdd                  = { bg = "#e4e5c8" },
  DiffChange               = { bg = "#f7eec9" },
  DiffDelete               = { bg = "#f0dfc4" },
  DiffText                 = { bg = "#f5e0a9" },
  EndOfBuffer              = { fg = "#a3a194" },
  TermCursor               = { bg = "#3a6d78", fg = "#f8f5d7" },

  -- TODO: TermCursorNC.
  -- TODO: ErrorMsg.

  WinSeparator             = { fg = "#d7d4ba" },

  -- TODO: Folded.
  -- TODO: FoldedColumn.
  -- TODO: SignColumn.

  IncSearch                = { bg = "#ffff00", fg = "#1f1d1a", bold = true },
  Substitute               = { bg = "#ffff00", fg = "#1f1d1a", bold = true },
  LineNr                   = { fg = "#a3a194" },

  -- TODO: LineNrAbove.
  -- TODO: LineNrBelow.

  CursorLineNr             = { bold = true, fg = "#66655d", bg = "#f3f0d3" },

  -- TODO: CursorLineFold.
  -- TODO: CursorLineSign.

  MatchParen               = { bg = "#bfccba" },

  -- TODO: ModeMsg. (Hidden).

  MsgArea                  = { bg = "#edeacd", fg = "#1f1d1a" },

  -- TODO: MsgSeparator.
  -- TODO: MoreMsg.

  NonText                  = { fg = "#d7d4ba" },
  Normal                   = { bg = "#f8f5d7", fg = "#1f1d1a" },
  NormalFloat              = { bg = "#edeacd", fg = "#1f1d1a" },

  -- TODO: FloatBorder.
  -- TODO: FloatTitle.
  -- TODO: FloatFooter.
  -- TODO: NormalNC.

  Pmenu                    = { bg = "#faca6e", fg = "#1f1d1a" },
  PmenuSel                 = { bold = true, bg = "#1f1d1a", fg = "#f8f5d7" },

  -- TODO: PmenuKind.
  -- TODO: PmenuExtra.
  -- TODO: PmenuExtraSel.
  -- TODO: PmenuSbar.

  PmenuThumb               = { bg = "#d9b058" },

  -- TODO: Question.
  -- TODO: QuickFixLine.

  Search                   = { bg = "#ffff00", fg = "#1f1d1a", bold = true },

  -- TODO: SnippetTabstop.
  -- TODO: SpecialKey.

  SpellBad                 = { sp = "#af1f1b", underline = true },
  SpellCap                 = { sp = "#243bb5", underline = true },
  SpellLocal               = { sp = "#243bb5", underline = true },

  -- TODO: SpellRare.

  StatusLine               = { bg = "#edeacd", fg = "#1f1d1a" },

  -- TODO: StatusLineNC.
  -- TODO: TabLine.
  -- TODO: TabLineFill.
  -- TODO: TabLineSel.
  -- TODO: Title.

  Visual                   = { bg = "#bfccba" },

  -- TODO: VisualNOS.
  -- TODO: WarningMsg.

  Whitespace               = { fg = "#d7d4ba" },

  -- TODO: WildMenu.
  -- TODO: WinBar.
  -- TODO: WinBarNC.

  -- See diagnostic-highlights.
  DiagnosticError          = { bg = "#edd4ba", fg = "#1f1d1a" },
  DiagnosticWarn           = { bg = "#f5e0a9", fg = "#1f1d1a" },
  DiagnosticHint           = { bg = "#f5e0a9", fg = "#1f1d1a" },
  DiagnosticUnderlineError = { sp = "#af1f1b", underline = true },
  DiagnosticUnderlineWarn  = { sp = "#f2cc7c", underline = true },
  DiagnosticUnderlineHint  = { sp = "#f2cc7c", underline = true },
  DiagnosticUnnecessary    = { link = "Ignore" },

  -- See gitsigns-highlight-groups.
  GitSignsAdd              = { fg = "#385541" },
  GitSignsDelete           = { fg = "#af1f1b" },
  GitSignsChange           = { fg = "#f2cc7c" },

  -- See plugin/telescope.lua.
  TelescopeBorder          = { fg = "#d7d4ba" },
  TelescopeSelection       = { bg = "#ece9d2", fg = "#1f1d1a" },
  TelescopeTitle           = { bold = true, fg = "#66655d" },
}

vim.opt.background = "light"

vim.cmd.highlight("clear")
vim.g.colors_name = "semafor"

-- TODO: Terminal colours.

for k, v in pairs(groups) do
  vim.api.nvim_set_hl(0, k, v)
end
