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

vim.cmd.highlight("OverrideStatusLine guibg=#434c5e guifg=#d8dee9")
vim.opt.statusline = "%#OverrideStatusLine#%-F %m %-r %= %{%v:lua.current_branch()%}  %l,%c %p%%  %y"
