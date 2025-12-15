require'nvim-treesitter'.install { 'lua', 'typescript', 'javascript', 'php', 'twig', 'scss' }

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'typescript', 'javascript', 'php', 'twig', 'scss' },
  callback = function()
      vim.treesitter.start()
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'php',
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})
