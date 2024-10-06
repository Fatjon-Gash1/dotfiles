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

-- Local functions
local auto_save_enabled = true

local function save_with_delay()
	if auto_save_enabled then
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
end

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
	callback = save_with_delay,
})

vim.api.nvim_create_user_command("SaveToggle", function()
	auto_save_enabled = not auto_save_enabled
	if auto_save_enabled then
		print("Auto-save enabled")
	else
		print("Auto-save disabled")
	end
end, {})

local original_notify = vim.notify

vim.notify = function(msg, ...)
	if not (msg:match("completion request failed") or msg:match("Formatter failed")) then
		original_notify(msg, ...)
	end
end
