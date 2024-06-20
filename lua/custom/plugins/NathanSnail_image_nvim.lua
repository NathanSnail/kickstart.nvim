return {
	event = "VeryLazy",
	dependencies = {
		{ "luarocks.nvim" },
		{
			"nvim-treesitter/nvim-treesitter",
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup {
					ensure_installed = { "markdown" },
					highlight = { enable = true },
				}
			end,
		},
	},
	opts = {
		backend = "kitty",
		integrations = {
			markdown = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
			},
			neorg = {
				enabled = true,
				clear_in_insert_mode = false,
				download_remote_images = true,
				only_render_image_at_cursor = false,
				filetypes = { "norg" },
			},
		},
		max_width = nil,
		max_height = nil,
		max_width_window_percentage = nil,
		max_height_window_percentage = 50,
		kitty_method = "normal",
		hijack_hook = function(img, buf, defaults)
			defaults()
			vim.api.nvim_buf_set_keymap(buf, "n", "k", ":ImageUp<CR>", { silent = true })
			vim.api.nvim_buf_set_keymap(buf, "n", "j", ":ImageDown<CR>", { silent = true })
			vim.api.nvim_buf_set_keymap(buf, "n", "h", ":ImageLeft<CR>", { silent = true })
			vim.api.nvim_buf_set_keymap(buf, "n", "l", ":ImageRight<CR>", { silent = true })
			vim.api.nvim_buf_set_keymap(buf, "n", "o", ":ImageSmaller<CR>", { silent = true })
			vim.api.nvim_buf_set_keymap(buf, "n", "i", ":ImageBigger<CR>", { silent = true })
		end,
	},
}
