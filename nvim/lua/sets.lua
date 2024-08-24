vim.opt.nu = true
vim.opt.rnu = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.g.mapleader = " "
vim.opt.showmode = false
vim.opt.clipboard = "unnamedplus"
vim.opt.undofile = true
vim.opt.breakindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.list = true
vim.opt.listchars = { tab = "󰞔 ", trail = "·", nbsp = "␣" }
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.termguicolors = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "auto"

local function save_with_delay()
	vim.defer_fn(function()
		if vim.bo.buftype == "" then
			vim.cmd("write")
			local time = os.date("*t")
			print(string.format("File saved at: %02d:%02d:%02d", time.hour, time.min, time.sec))
		else
			print(vim.bo.buftype)
		end
	end, 1000)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	buffer = 0,
	callback = save_with_delay,
})
