require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"intelephense",
		"jdtls",
		"pylsp",
		"html",
		"svelte",
		"tailwindcss",
		"ts_ls",
		"cssls",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"vale",
		"eslint_d",
		"stylelint",
		"pylint",
		"checkstyle",
		"stylua",
		"prettier",
	},
})

local null_ls = require("null-ls")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local on_attach = function(_, _)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
	vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {})
	vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
end

-- Only for lsps that don't detect root
local dirFind = function()
	return vim.loop.cwd()
end

null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.diagnostics.cspell.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.severity = vim.diagnostic.severity.WARN
			end,
			filetypes = { "markdown", "text", "javascript", "typescript", "html", "css" },
		}),
		null_ls.builtins.code_actions.cspell,
	},
})

require("lspconfig").lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").intelephense.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	root_dir = dirFind,
})

require("lspconfig").jdtls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").pylsp.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").html.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").svelte.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").tailwindcss.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").ts_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

require("lspconfig").cssls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
