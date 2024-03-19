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

return {
	"tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically

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
	file "NeogitOrg/neogit",
	file "bluz71/vim-nightfly-colors",
	file "nvim-tree/nvim-tree.lua",
	file "NathanSnail/image.nvim",
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	"HallerPatrick/py_lsp.nvim",
	-- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
	-- init.lua. If you want these files, they are in the repository, so you can just download them and
	-- put them in the right spots if you want.

	-- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
	--
	--  Here are some example plugins that I've included in the kickstart repository.
	--  Uncomment any of the lines below to enable them (you will need to restart nvim).
	--
	-- require 'kickstart.plugins.debug',
	-- require 'kickstart.plugins.indent_line',

	-- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
	--	This is the easiest way to modularize your config.
	--
	--  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
	--	For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
	-- { import = 'custom.plugins' },
}
