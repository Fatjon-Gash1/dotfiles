vim.g.ale_linters = {
	markdown = { "cspell" },
	typescript = { "cspell" },
	javascript = { "cspell" },
	typescriptreact = { "cspell" },
	javascriptreact = { "cspell" },
	svelte = { "cspell" },
	css = { "cspell" },
	python = { "cspell" },
	java = { "cspell" },
	handlebars = { "cspell" },
}
vim.g.ale_linters_explicit = 1

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
	handlebars = { "djlint" },
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

-- Configure diagnostics display settings
vim.diagnostic.config({
	virtual_text = {
		format = function(diagnostic)
			local message = diagnostic.message
			local max_width = 80
			if #message > max_width then
				return string.sub(message, 1, max_width) .. "..."
			else
				return message
			end
		end,
	},
	float = {
		source = "always", -- Always show linter source (e.g., ESLint)
		border = "rounded", -- Use rounded border for floating window
	},
	underline = true, -- Underline lines with errors/warnings
	severity_sort = true, -- Sort diagnostics by severity (Errors > Warnings)
})
