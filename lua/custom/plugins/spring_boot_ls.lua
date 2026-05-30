-- Spring Boot Language Server — installed via mason (vscode-spring-boot-tools)
-- Provides completion and validation for application.yml / application.properties
-- based on the project's actual Spring Boot dependencies and classpath.
local mason_ls_dir = vim.fn.stdpath 'data' .. '/mason/packages/vscode-spring-boot-tools/extension/language-server'
local jar = vim.fn.glob(mason_ls_dir .. '/spring-boot-language-server-*-exec.jar')

if jar == '' or vim.fn.filereadable(jar) == 0 then return end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    'application*.yml',
    'application*.yaml',
    'application*.properties',
    'bootstrap*.yml',
    'bootstrap*.yaml',
    'bootstrap*.properties',
  },
  callback = function(ev)
    local root = vim.fs.root(ev.buf, { 'pom.xml', 'build.gradle', 'build.gradle.kts' })
    if not root then return end
    vim.lsp.start({
      name = 'spring-boot-ls',
      cmd = { 'java', '-jar', jar },
      root_dir = root,
    }, { bufnr = ev.buf })
  end,
})
