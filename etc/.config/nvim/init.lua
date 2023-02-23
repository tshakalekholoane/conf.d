local modules = {
  "colourscheme",
  "completions",
  "finder",
  "languageservers",
  "parser",
  "plugins",
  "statusline",
  "versioncontrol",
}

for _, module in ipairs(modules) do
  local ok, error_message = pcall(require, module)
  if not ok then
    print(string.format("init: %s: %s\n", module, error_message))
  end
end
