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

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.py" },
	callback = function()
		print "hi"
		vim.opt.foldmethod = "expr"
		vim.cmd "set foldexpr=nvim_treesitter#foldexpr()"
		vim.opt.foldenable = false
	end,
})

return {
	-- "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
	-- NOTE: don't use spaces ever.

	-- "gc" to comment visual regions/lines
	force "numToStr/Comment.nvim",
	file "lewis6991/gitsigns.nvim",
	file "folke/which-key.nvim",
	file "nvim-telescope/telescope.nvim",
	file "neovim/nvim-lspconfig",

	file "stevearc/conform.nvim",
	file "Saecki/crates.nvim",

	file "hrsh7th/nvim-cmp",

	-- Highlight todo, notes, etc in comments
	{ "folke/todo-comments.nvim", event = "VimEnter", dependencies = { "nvim-lua/plenary.nvim" }, opts = {} },

	file "echasnovski/mini.nvim",

	file "nvim-treesitter/nvim-treesitter",
	file "bluz71/vim-nightfly-colors",
	file "nvim-tree/nvim-tree.lua",
	--file "NathanSnail/image.nvim",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{ "RaafatTurki/hex.nvim" },
	file "ThePrimeagen/harpoon",
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
	"lambdalisue/suda.vim",
	"mbbill/undotree",
}
