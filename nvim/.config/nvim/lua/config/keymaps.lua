-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down & recenter" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up & recenter" })

vim.keymap.set("n", "<C-p>", function()
  require("fzf-lua").files({
    actions = {
      default = require("fzf-lua.actions").file_edit,
      ["ctrl-x"] = require("fzf-lua.actions").file_vsplit,
    },
  })
end, { desc = "Find files (ctrl-x = vsplit)" })

vim.keymap.set("n", "<Tab>", "<C-w>p", { desc = "Toggle between splits" })

vim.keymap.set("n", "<M-CR>", function()
  require("fzf-lua").files({
    actions = {
      default = require("fzf-lua.actions").file_split,
    },
  })
end, { desc = "Find files (split)" })
