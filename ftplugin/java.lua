vim.schedule(function()
  local ok, jdtls = pcall(require, "jdtls")
  if not ok then
    vim.notify("nvim-jdtls not found", vim.log.levels.ERROR)
    return
  end

  local java_home = os.getenv("JAVA_HOME")
  if not java_home then
    vim.notify("JAVA_HOME is not set", vim.log.levels.ERROR)
    return
  end

  local java = java_home .. "/bin/java"
  if vim.fn.executable(java) == 0 then
    vim.notify("Java executable not found: " .. java, vim.log.levels.ERROR)
    return
  end

  local data = vim.fn.stdpath("data")
  local jdtls_pkg = data .. "/mason/packages/jdtls"
  local launcher = vim.fn.glob(jdtls_pkg .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local os_config = "config_mac"  -- change to config_linux or config_win on other OSes
  local workspace = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

  local config = {
    cmd = {
      java,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", launcher,
      "-configuration", jdtls_pkg .. "/" .. os_config,
      "-data", workspace,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
    settings = {
      java = {
        configuration = {
          runtimes = {
            { name = "JavaSE-17", path = java_home },
          },
        },
        inlayHints = { parameterNames = { enabled = "all" } },
      },
    },
    init_options = {
      bundles = vim.split(
        vim.fn.glob(data .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"),
        "\n"
      ),
    },
  }

  jdtls.start_or_attach(config)
end)
