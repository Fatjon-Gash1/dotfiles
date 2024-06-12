local lint = require("lint")
lint.linters_by_ft = {
	markdown = { "vale" },
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	svelte = { "eslint_d" },
	css = { "stylelint" },
	python = { "pylint" },
	java = { "checkstyle" },
}

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
	group = lint_augroup,
	callback = function()
		lint.try_lint()
	end,
})

require("lint.linters.checkstyle").args = {
	"-c",
	"/home/fatjon/Dotfiles/checkstyle.xml",
	"--",
	"-f",
	"xml",
	"$FILENAME",
}
