-- in ~/.config/nvim/ftplugin/java.lua (or your LSP config)
local jdtls = require("jdtls")

-- Tell jdtls to run under the Java version set in your shell
vim.env.JAVA_HOME = os.getenv("JAVA_HOME") -- make sure it's set before launching Neovim

local java_cmd = vim.env.JAVA_HOME .. "/bin/java"

local config = {
	cmd = {
		java_exec,
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		jdtls_path .. "/config_mac", -- or config_linux, config_win
		"-data",
		vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t"),
	},
	root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew" }),
	settings = {
		java = {
			configuration = {
				runtimes = {
					{ name = "JavaSE-17", path = os.getenv("JAVA_HOME") },
					-- add other versions if you install them
				},
			},
			inlayHints = { parameterNames = { enabled = "all" } },
		},
	},
	init_options = {
		bundles = vim.split(
			vim.fn.glob(
				vim.fn.stdpath("data")
					.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
			),
			"\n"
		),
	},
}

jdtls.start_or_attach(config)
