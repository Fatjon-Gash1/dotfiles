require'nvim-treesitter'.install {
	"c",
	"lua",
	"vim",
	"vimdoc",
	"query",
	"javascript",
	"typescript",
	"php",
	"java",
	"python",
	"html",
	"css",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = {
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"javascript",
		"typescript",
		"php",
		"java",
		"python",
		"html",
		"css",
	},
	callback = function()
		vim.treesitter.start()
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
