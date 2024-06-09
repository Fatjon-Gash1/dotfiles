local theme1 = 'minimal'
local theme2 = 'kanagawa'

local currentTheme = theme1
vim.cmd.colorscheme(currentTheme)

local function st()
	if currentTheme == theme1 then
		currentTheme = theme2
	else
		currentTheme = theme1
	end
	vim.cmd.colorscheme(currentTheme)
end

_G.st = st
