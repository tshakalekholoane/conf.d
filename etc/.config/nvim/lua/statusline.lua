function current_branch()
  if vim.b.git_branch == nil then
    local current    = vim.fn.system("git branch --show-current 2> /dev/null")
    vim.b.git_branch = current ~= "" and current:gsub("\n", "") or ""
  end
  return vim.b.git_branch
end

vim.api.nvim_create_autocmd({ "BufEnter", "VimEnter", "WinEnter" }, {
  callback = current_branch,
})

vim.opt.statusline = "%-F %m %-r %= %{%v:lua.current_branch()%}  %l,%c %p%%  %y"
