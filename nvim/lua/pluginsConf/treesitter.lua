require'nvim-treesitter'.install { 'lua', 'typescript', 'javascript', 'php', 'twig', 'scss', 'python' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'typescript', 'javascript', 'php', 'twig', 'scss', 'python' },
  callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
