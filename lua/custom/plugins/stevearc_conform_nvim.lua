return {
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>ff",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "[F]ormat [F]ile",
		},
	},
	opts = {
		notify_on_error = false,
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			objc = { "clang_format" },
			objcpp = { "clang_format" },
			cuda = { "clang_format" },
			proto = { "clang_format" },
			-- xml = { "xmlformat" },
			python = {
				-- "isort",
				"black",
				-- "unexpand", it's just too hard to go against the python formatter, even though it's clearly wrong
			},
			json = { "jq" },
			-- Conform can also run multiple formatters sequentially
			-- python = { "isort", "black" },
			--
			-- You can use a sub-list to tell conform to run *until* a formatter
			-- is found.
			-- javascript = { { "prettierd", "prettier" } },
		},
		formatters = {
			unexpand = {
				command = "unexpand",
				args = { "-t", "4", "--first-only" },
			},
			xmlformat = {
				args = { "--indent-char=\t", "-" },
			},
			clang_format = {
				args = { "--style={UseTab: Always, IndentWidth: 6, TabWidth: 6}" },
			},
			jq = {
				command = "jq",
				args = { "--tab" },
			},
		},
	},
}
