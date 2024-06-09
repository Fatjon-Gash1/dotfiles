vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', '<a-h>', '<cmd>nohlsearch<CR>')
vim.keymap.set("n", "<leader>gs", vim.cmd.Git);
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
vim.keymap.set('n', '<a-f>', ':NvimTreeFocus<CR>')
