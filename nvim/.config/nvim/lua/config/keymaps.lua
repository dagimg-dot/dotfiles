-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

vim.api.nvim_set_keymap(
  "n",
  "<M-CR>",
  '<cmd>lua require("fzf-lua").files({ actions = { ["default"] = require("fzf-lua.actions").file_split } })<CR>',
  { noremap = true, silent = true }
)
