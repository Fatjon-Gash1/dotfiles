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
    automatic_enable = { "intelephense" }
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
		"jsonlint",
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

null_ls.setup({
	on_attach = on_attach,
})

vim.lsp.config("lua_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("jdtls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("pylsp", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("html", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("svelte", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("tailwindcss", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("ts_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.config("css_ls", {
	on_attach = on_attach,
	capabilities = capabilities,
})

vim.lsp.enable({
    "lua_ls",
    "jdtls",
    "pylsp",
    "html",
    "svelte",
    "tailwindcss",
    "ts_ls",
    "css_ls",
})

