return {
	opts = {},
	-- Optional dependencies
	-- dependencies = { { "echasnovski/mini.icons", opts = {} } },
	dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
	config = function()
		require("oil").setup({})
		vim.keymap.set("n", "<CA-T>", function()
			vim.api.nvim_command(":Oil")
		end)
	end,
}
