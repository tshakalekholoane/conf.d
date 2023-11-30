local builtin = require "telescope.builtin"
local telescope = require "telescope"
local themes = require "telescope.themes"

local configuration = {
  pickers = {
    find_files = {
      find_command = { "fd", "--type", "file", "--follow", "--hidden", "--exclude", ".git" },
    },
  },
}

local function find_in_file()
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end

vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[f]ind [b]uffers" })
vim.keymap.set("n", "<leader>fc", find_in_file, { desc = "Find in file" })
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ind [f]ile" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[f]ile [g]rep" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[f]ind in [h]elp" })
vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "List references" })

telescope.setup(configuration)
telescope.load_extension("fzf")
