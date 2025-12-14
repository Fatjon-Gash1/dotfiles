require'nvim-treesitter'.install { 'lua', 'typescript', 'javascript', 'php', 'twig', 'scss' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'typescript', 'javascript', 'php', 'twig', 'scss' },
  callback = function() vim.treesitter.start() end,
})
