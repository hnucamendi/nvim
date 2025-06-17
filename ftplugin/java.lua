vim.schedule(function()
  local status_ok, jdtls = pcall(require, "jdtls")
  if not status_ok then
    vim.notify("nvim-jdtls not found", vim.log.levels.ERROR)
    return
  end

  local java_home = os.getenv("JAVA_HOME")
  if not java_home then
    vim.notify("JAVA_HOME is not set", vim.log.levels.ERROR)
    return
  end

  local java_exec = java_home .. "/bin/java"
  local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
  local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
  local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

  local config = {
    cmd = {
      java_exec,
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xmx1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar", launcher_jar,
      "-configuration", jdtls_path .. "/config_mac", -- or config_linux/config_win if applicable
      "-data", workspace_dir,
    },
    root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
    settings = {
      java = {
        configuration = {
          runtimes = {
            { name = "JavaSE-17", path = java_home },
            -- Add others if needed
          },
        },
        inlayHints = { parameterNames = { enabled = "all" } },
      },
    },
    init_options = {
      bundles = vim.split(
        vim.fn.glob(
          vim.fn.stdpath("data") ..
            "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
        ),
        "\n"
      ),
    },
  }

  jdtls.start_or_attach(config)
end)
