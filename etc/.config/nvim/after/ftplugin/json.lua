local function format_json()
  vim.cmd("!jq --indent 2 '.' % > %~ && mv %~ %")
end

vim.keymap.set("n", "<space>f", format_json)
