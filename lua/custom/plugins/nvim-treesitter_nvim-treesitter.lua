return {
	build = ":TSUpdate",
	config = function()
		-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"bash",
				"c",
				"html",
				"lua",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"ron",
				"toml",
				"python",
				"go",
				"java",
			},
			-- Autoinstall languages that are not installed
			auto_install = true,
			highlight = { enable = true, disable = { "xml", "xsd", "csv" } },
			indent = { enable = true },
		})

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--	- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--	- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--	- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
	opts = function(_, opts)
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		opts.ensure_installed = opts.ensure_installed or {}
		table.insert(opts.ensure_installed, "hexpat")

		parser_config.hexpat = {
			install_info = {
				url = "/home/nathan/Documents/code/tree-sitter-hexpat",
				files = { "src/parser.c" },
				generate_requires_npm = false,
				requires_generate_from_grammar = false,
			},
			filetype = "hexpat",
		}
	end,
}
