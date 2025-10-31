return {
	ft = { "java" },
	dependencies = { "nvim-dap" },
	config = function()
		local jdtls = require("jdtls")
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = function()
				local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
				local root_dir = require("jdtls.setup").find_root(root_markers)

				if not root_dir then return end

				local config = {
					cmd = {
						"jdtls",
					},
					root_dir = root_dir,
					settings = {
						java = {
							-- Java-specific settings
						},
					},
					init_options = {
						bundles = {},
					},
				}
				jdtls.start_or_attach(config)
			end,
		})
	end,
}
