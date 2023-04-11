function current_branch()
  if vim.b.git_branch ~= nil then
    return vim.b.git_branch
  end
  local current = vim.fn.system("git branch --show-current 2> /dev/null")
  vim.b.git_branch = current ~= "" and current:gsub("\n", "") or ""
  return vim.b.git_branch
end

vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter", "WinEnter" }, {
  callback = current_branch,
})

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

-- Gruvbox themed palette for mode indicator. See the following for
-- details https://github.com/morhetz/gruvbox.
local foreground = "guifg=#fbf1c7"
local palette = {
  "#689d6a", -- Aqua.
  "#458588", -- Blue.
  "#928374", -- Gray.
  "#d65d0e", -- Orange.
}
for index, colour in ipairs(palette) do
  local options = { "User" .. index, "guibg=" .. colour, foreground }
  vim.cmd.highlight(options)
end

vim.opt.showmode = false
vim.opt.statusline = "%{%v:lua.current_mode()%} %-F %m %-r %= %{%v:lua.current_branch()%}  %l,%c %p%%  %y"
