return {
	ft = { "java" },
	dependencies = { "nvim-dap" },
	config = function()
		local jdtls = require("jdtls")
		local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
		local root_dir = require("jdtls.setup").find_root(root_markers)
		local home = vim.env.HOME

		if root_dir then
			local workspace_folder = home
				.. "/.local/share/eclipse/"
				.. vim.fn.fnamemodify(root_dir, ":p:h:t")

			local config = {
				cmd = {
					"java", -- Ensure 'java' is in your PATH or specify the full path
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xms1g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-jar",
					vim.fn.glob(
						home
							.. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
					),
					"-configuration",
					home
						.. "/.local/share/nvim/mason/packages/jdtls/config_"
						.. vim.loop.os_uname().sysname,
					"-data",
					workspace_folder,
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
		end
	end,
}
