-- theme config
require("tokyonight").setup({
	style = "storm", -- `storm`, `moon`,`night` and `day`
	light_style = "day", -- The theme is used when the background is set to light
	transparent = true,
	styles = {
		comments = { italic = false },
		keywords = { italic = false },
		-- Background styles. Can be "dark", "transparent" or "normal"
		sidebars = "transparent", -- style for sidebars
		floats = "transparent", -- style for floating windows
	},
	sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
	day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
})

local theme1 = "tokyonight"
local theme2 = "kanagawa"
local theme3 = "minimal"

local currentTheme = theme1
vim.cmd.colorscheme(currentTheme)

local function chTheme()
	if currentTheme == theme1 then
		currentTheme = theme2
	elseif currentTheme == theme2 then
		currentTheme = theme3
	else
		currentTheme = theme1
	end
	vim.cmd.colorscheme(currentTheme)
end

_G.chTheme = chTheme
-- Invoke with :lua chTheme()
