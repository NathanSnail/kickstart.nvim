return {
	dependencies = {
		-- Automatically install LSPs and related tools to stdpath for neovim
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",

		-- Useful status updates for LSP.
		"saghen/blink.cmp",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- gd in init.lua for man pages

				map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
				map(
					"gI",
					require("telescope.builtin").lsp_implementations,
					"[G]oto [I]mplemetations"
				)

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map(
					"<leader>D",
					require("telescope.builtin").lsp_type_definitions,
					"Type [D]efinition"
				)

				-- Rename the variable under your cursor
				--  Most Language Servers support renaming across files, etc.
				map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

				-- Execute a code action, usually your cursor needs to be on top of an error
				-- or a suggestion from your LSP for this to activate.
				map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

				-- Opens a popup that displays documentation about the word under your cursor
				--  See `:help K` for why this keymap
				map("<A-f>", vim.lsp.buf.hover, "[F]ind Documentation")
				map("<A-i>", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, "[I]nlay Hints")

				-- The following two autocommands are used to highlight references of the
				-- word under your cursor when your cursor rests there for a little while.
				--	See `:help CursorHold` for information about when this is executed
				--
				-- When you move your cursor, the highlights will be cleared (the second autocommand).
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if client and client.server_capabilities.documentHighlightProvider then
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.document_highlight,
					})

					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})

		-- LSP servers and clients are able to communicate to each other what features they support.
		--  By default, Neovim doesn't support everything that is in the LSP Specification.
		--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
		--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		--  Add any additional override configuration in the following tables. Available keys are:
		--  - cmd (table): Override the default command used to start the server
		--  - filetypes (table): Override the default list of associated filetypes for the server
		--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
		--  - settings (table): Override the default settings passed when initializing the server.
		--		For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
		local servers = {
			zls = { settings = { enable_build_on_save = true } },
			clangd = {},
			pyright = {},
			lemminx = {
				settings = {
					xml = {
						fileAssociations = {
							{
								systemId = "/home/nathan/Documents/code/noita_xml_dtd/out/merged.xsd",
								pattern = "**/*.xml",
							},
						},
					},
				},
			},
			-- python_lsp_server
			rust_analyzer = {},
			-- hls = {},
			glsl_analyzer = {},
			gopls = {
				root_dir = function(fname)
					local util = require("lspconfig.util")
					return util.root_pattern("go.work")(fname)
						or util.root_pattern("go.mod", ".git")(fname)
				end,
			},
			matlab_ls = {
				matlab = {
					capabilities = require("blink.cmp").get_lsp_capabilities(),
					indexWorkspace = true,
					--installPath = "/home/nathan/MATLAB/R2024a/",
					matlabConnectionTiming = "onStart",
				},
				root_dir = function(fname)
					return require("lspconfig.util").find_git_ancestor(fname)
						or require("lspconfig.util").root_pattern("compile_commands.json")(fname)
						or require("lspconfig.util").root_pattern("Makefile")(fname)
						or require("lspconfig.util").root_pattern("xmake.lua")(fname)
				end,
				single_file_support = true,
			},
			lua_ls = {
				-- cmd = {...},
				-- filetypes { ...},
				-- capabilities = {},
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							ignoreSubmodules = false,
							checkThirdParty = false,
							library = {
								-- "${3rd}/luv/library",
								"~/Documents/code/AutoLuaAPI/out.lua", --- NOTE: Nathan Noita API defs
								-- "~/.local/share/Steam/steamapps/common/Primordialis Demo/data/scripts/lua_mods/",
								-- "~/Documents/code/Noita-Dear-ImGui/imguidoc/imgui_definitions.lua",
								-- "~/.luarocks/",
								--unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						completion = {
							callSnippet = "Replace",
							autoRequire = true,
						},
					},
				},
			},
		}

		require("mason").setup()

		local ensure_installed = vim.tbl_keys(servers or {})
		vim.list_extend(ensure_installed, {
			"stylua", -- Used to format lua code
			"black", -- formatter
			"isort", -- organize imports
			"lemminx", -- xml lsp
			"xmlformatter", -- xml format
			"clang-format", -- c like formatter
			"clangd", -- its c++ / c
			"glsl_analyzer", -- glsl lsp
			"rust_analyzer", -- rust lsp
			"gopls",
			"java-debug-adapter",
			"java-test",
			"cmake-language-server",
			"json-lsp",
			"jdtls",
		})
		require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

		for k, v in pairs(servers) do
			vim.lsp.config(k, v)
			vim.lsp.enable(k)
		end
	end,
}
