-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Code grab and move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the middle for half page navigation
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.api.nvim_set_keymap("n", "<leader>n", ":ASToggle<CR>", {})

-- remove remaping of "ctrl+c" combo with the "esc"
vim.api.nvim_set_keymap("i", "<C-c>", "<Esc>", { noremap = true, silent = true })
