return {
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		vim.keymap.set("n", "<C-5>", function()
			require("harpoon.ui").toggle_quick_menu()
		end)
		vim.keymap.set("n", "<C-4>", function()
			require("harpoon.mark").add_file()
		end)
		vim.keymap.set("n", "<C-3>", function()
			require("harpoon.ui").nav_next()
		end)
		vim.keymap.set("n", "<C-2>", function()
			require("harpoon.ui").nav_prev()
		end)
	end,
}
