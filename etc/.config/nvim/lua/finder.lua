local telescope = require("telescope")
local telescope_builtin = require("telescope.builtin")
local telescope_themes = require("telescope.themes")
local ok, error_message = pcall(require("telescope").load_extension, "fzf")
if not ok then
  print("finder:", error_message)
end

local function find_in_file()
  telescope_builtin.current_buffer_fuzzy_find(telescope_themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

vim.keymap.set("n", "<leader>fb", telescope_builtin.buffers, {})
vim.keymap.set("n", "<leader>fc", find_in_file, {})
vim.keymap.set("n", "<leader>ff", telescope_builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", telescope_builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", telescope_builtin.help_tags, {})

telescope.setup {
  pickers = {
    find_files = {
      find_command = {
        "fd",
        "--type",
        "file",
        "--follow",
        "--hidden",
        "--exclude",
        ".git",
      },
    },
  },
}
