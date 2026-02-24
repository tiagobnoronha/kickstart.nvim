local jdtls_ok, jdtls = pcall(require, "jdtls")
if not jdtls_ok then
  return
end

-- Ensure we only attach once per buffer
if vim.b.jdtls_attached then
  return
end
vim.b.jdtls_attached = true

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local lombok_path = jdtls_path .. "/lombok.jar"

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/site/java/workspace-root/" .. project_name

local os_config = "config_mac"
if vim.fn.has("linux") == 1 then
  os_config = "config_linux"
elseif vim.fn.has("win32") == 1 then
  os_config = "config_win"
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", jdtls_path .. "/" .. os_config,
    "-data", workspace_dir,
  },
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org"
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        },
        hashCodeEquals = {
          useJava7Objects = true,
        },
        useBlocks = true,
      },
    }
  },
  init_options = {
    bundles = {}
  },
}

-- Set capabilities via blink.cmp 
local capabilities = require("blink.cmp").get_lsp_capabilities()
config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

-- Start or attach to the language server
jdtls.start_or_attach(config)
