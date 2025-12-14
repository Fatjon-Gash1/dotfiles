require'nvim-treesitter'.install { 'typescript', 'javascript', 'php', 'twig', 'lua' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typescript', 'javascript', 'php', 'twig', 'lua' },
  callback = function() vim.treesitter.start() end,
})
