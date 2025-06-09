---@param name string
---@return table
local function file(name)
	local extra = require("lua/custom/plugins/" .. name:gsub("/", "_"):gsub("%.", "_"))
	extra[1] = name
	return extra
end

---@param name string
---@return table
local function force(name)
	-- Use `opts = {}` to force a plugin to be loaded.
	--  This is equivalent to:
	--	require('Comment').setup({})
	return { name, opts = {} }
end

vim.g.rust_recommended_style = 0

local themes = {
	"folke/tokyonight.nvim",
	"EdenEast/nightfox.nvim",
	"catppuccin/nvim",
	"rebelot/kanagawa.nvim",
	"navarasu/onedark.nvim",
	"neanias/everforest-nvim",
	"sho-87/kanagawa-paper.nvim",
	"comfysage/evergarden",
	"sainnhe/edge",
	"Shatur/neovim-ayu",
	"rjshkhr/shadow.nvim",
	"bluz71/vim-moonfly-colors",
}

local colourschemes = {
	"nightfly",
	"retrobox",
	"randomhue",
	"catppuccin-mocha",
	"catppuccin-macchiato",
	"catppuccin-frappe",
	"onedark",
	"kanagawa-wave",
	"everforest",
	"edge",
	"carbonfox",
	"ayu-dark",
	"ayu-mirage",
	"shadow",
	"moonfly",
}

local scheme = "nightfly"

vim.api.nvim_create_user_command("Paint", function()
	local choice
	repeat
		choice = colourschemes[math.random(#colourschemes)]
	until choice ~= scheme
	scheme = choice
	vim.api.nvim_command(":colo " .. choice)
end, { bang = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*" },
	callback = function(event)
		local buf = event.buf
		vim.api.nvim_buf_create_user_command(buf, "Noiter", function()
			local path = vim.api.nvim_buf_get_name(buf)
			for x in path:gmatch("/mods/.*") do
				vim.fn.setreg("+", x:sub(2))
				return
			end
			for x in path:gmatch("/data/.*") do
				vim.fn.setreg("+", x:sub(2))
				return
			end
		end, { bang = true })
	end,
})

local ret = {
	-- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- NOTE: don't use spaces ever.

	file("lewis6991/gitsigns.nvim"),
	file("nvim-telescope/telescope.nvim"),
	file("neovim/nvim-lspconfig"),

	file("stevearc/conform.nvim"),
	file("Saecki/crates.nvim"),

	file("hrsh7th/nvim-cmp"),

	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	{
		"noita-modman",
		dir = "~/Documents/code/noita-modman",
		config = function()
			require("noita-modman").setup(
				"/home/nathan/.local/share/Steam/steamapps/compatdata/881100/pfx/drive_c/users/steamuser/AppData/LocalLow/Nolla_Games_Noita/save00/mod_config.xml"
			)
		end,
	},

	file("echasnovski/mini.nvim"),

	file("nvim-treesitter/nvim-treesitter"),
	file("bluz71/vim-nightfly-colors"),
	-- file "nvim-tree/nvim-tree.lua",
	file("stevearc/oil.nvim"),
	{ "RaafatTurki/hex.nvim" },
	file("ThePrimeagen/harpoon"),
	-- require 'kickstart.plugins.debug',
	{ "tikhomirov/vim-glsl" },
	{ "kaarmu/typst.vim", ft = "typst", lazy = false },
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "0.1.*",
		ft = "typst",
		build = function()
			require("typst-preview").update()
		end,
	},
	{
		"f-person/git-blame.nvim",
		-- load the plugin at startup
		event = "VeryLazy",
		-- Because of the keys part, you will be lazy loading this plugin.
		-- The plugin wil only load once one of the keys is used.
		-- If you want to load the plugin at startup, add something like event = "VeryLazy",
		-- or lazy = false. One of both options will work.
		opts = {
			-- your configuration comes here
			-- for example
			enabled = false, -- if you want to enable the plugin
			message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
			date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
			virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
		},
	},
	"lambdalisue/suda.vim",
	"mbbill/undotree",
	--[[{
		"cordx56/rustowl",
		dependencies = { "neovim/nvim-lspconfig" },
		config = function()
			require("lspconfig").rustowl.setup({ trigger = { hover = true } })
		end,
	},]]
	file("mfussenegger/nvim-jdtls"),
	-- TODO: make this work
	-- "DariusCorvus/tree-sitter-language-injection.nvim",
	require("lua/kickstart/plugins/debug"),
	{
		"m4xshen/hardtime.nvim",
		lazy = false,
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			disable_mouse = false, -- im a scrolling addict
			disabled_keys = {
				["<Up>"] = { "" },
				["<Down>"] = { "" },
				["<Left>"] = { "" },
				["<Right>"] = { "" },
			},
		},
	},
	{
		"cshuaimin/ssr.nvim",
		config = function()
			vim.keymap.set("n", "<leader>ssr", function()
				require("ssr").open()
			end)
		end,
	},
}

for _, v in ipairs(themes) do
	table.insert(ret, { v })
end

return ret
