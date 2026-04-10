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

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }
local root_dir = require("jdtls.setup").find_root(root_markers)
if root_dir == "" or root_dir == nil then
  root_dir = vim.fn.getcwd()
end

local project_name = vim.fn.fnamemodify(root_dir, ":p:t")
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
  root_dir = root_dir,
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
    bundles = (function()
      local bundles = {}
      -- java-debug-adapter
      local debug_jar = vim.fn.glob(
        vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
      )
      if debug_jar ~= "" then
        vim.list_extend(bundles, { debug_jar })
      end
      -- java-test
      vim.list_extend(bundles, vim.split(
        vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/java-test/extension/server/*.jar"),
        "\n",
        { trimempty = true }
      ))
      return bundles
    end)()
  },
}

-- Set capabilities via blink.cmp 
local capabilities = require("blink.cmp").get_lsp_capabilities()
config.capabilities = vim.tbl_deep_extend("force", capabilities, config.capabilities or {})

-- Start or attach to the language server
jdtls.start_or_attach(config)

-- Java-specific keymaps (only in Java buffers)
local buf = vim.api.nvim_get_current_buf()
local map = function(keys, func, desc)
  vim.keymap.set('n', keys, func, { buffer = buf, desc = 'Java: ' .. desc })
end

-- Code actions / refactoring
map('<leader>jo', jdtls.organize_imports, '[O]rganize Imports')
map('<leader>jv', jdtls.extract_variable, 'Extract [V]ariable')
map('<leader>jc', jdtls.extract_constant, 'Extract [C]onstant')
map('<leader>jm', function() jdtls.extract_method(true) end, 'Extract [M]ethod')

-- Testing (requires java-test bundle)
map('<leader>jt', jdtls.test_nearest_method, '[T]est Nearest Method')
map('<leader>jT', jdtls.test_class, '[T]est Class')

-- Build
map('<leader>jb', '<cmd>!mvn compile<CR>', '[B]uild (Maven)')
map('<leader>jB', '<cmd>!./mvnw compile<CR>', '[B]uild (Maven Wrapper)')
map('<leader>jg', '<cmd>!./gradlew build<CR>', '[B]uild (Gradle)')
