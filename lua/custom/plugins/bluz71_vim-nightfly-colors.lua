local debugging = true

local function colourise()
	require("nightfly").custom_colors({
		bg = "#040408", -- bg
		dark_blue = "#1A1F23", -- current line
		slate_blue = "#11111D", -- split border
		white = "#C9C9C9", -- split / uncoloured text
		grey_blue = "#a0a0a0", -- comments
		orchid = "#EB948F", -- params
		turquoise = "#20E0C0", -- namespace / macro
		emerald = "#30C083", -- types
		tan = "#DBB279", -- strings
		green = "#9DCD53", -- self
		watermelon = "#FF6980", -- ops
		lavender = "#ADBBF4", -- fields
		blue = "#75AEFF", -- funcs
		violet = "#CA9BEA", -- keywords
		regal_blue = "#152634", -- lsp same colour
	})
	if debugging then vim.cmd("colorscheme default") end
	vim.cmd("colorscheme nightfly")
end

if package.loaded["nightfly"] then colourise() end

return {
	name = "nightfly",
	lazy = false,
	priority = 1000,
	config = function(self, opts)
		colourise()
	end,
}
