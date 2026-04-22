local extra_servers = {
  ts_ls = {},
  cssls = {},
  dockerls = {},
  docker_compose_language_service = {},
  jsonls = {},
  yamlls = {
    settings = {
      yaml = {
        keyOrdering = false,
        schemaStore = {
          enable = true,
          url = 'https://www.schemastore.org/api/json/catalog.json',
        },
        schemas = {
          ['https://json.schemastore.org/spring-boot-application.json'] = {
            'application.yml',
            'application.yaml',
            'application-*.yml',
            'application-*.yaml',
          },
        },
      },
    },
  },
  emmet_ls = {
    filetypes = { 'html', 'css', 'scss', 'php', 'typescriptreact', 'javascriptreact' },
  },
  intelephense = {
    settings = {
      intelephense = {
        stubs = {
          'apache',
          'bcmath',
          'bz2',
          'calendar',
          'com_dotnet',
          'Core',
          'ctype',
          'curl',
          'date',
          'dba',
          'dom',
          'enchant',
          'exif',
          'FFI',
          'fileinfo',
          'filter',
          'fpm',
          'ftp',
          'gd',
          'gettext',
          'gmp',
          'hash',
          'iconv',
          'imap',
          'intl',
          'json',
          'ldap',
          'libxml',
          'mbstring',
          'meta',
          'mysqli',
          'oci8',
          'odbc',
          'openssl',
          'pcntl',
          'pcre',
          'PDO',
          'pdo_ibm',
          'pdo_mysql',
          'pdo_pgsql',
          'pdo_sqlite',
          'pgsql',
          'Phar',
          'posix',
          'pspell',
          'readline',
          'Reflection',
          'session',
          'shmop',
          'SimpleXML',
          'snmp',
          'soap',
          'sockets',
          'sodium',
          'SPL',
          'sqlite3',
          'standard',
          'superglobals',
          'sysvmsg',
          'sysvsem',
          'sysvshm',
          'tidy',
          'tokenizer',
          'xml',
          'xmlreader',
          'xmlrpc',
          'xmlwriter',
          'xsl',
          'Zend OPcache',
          'zip',
          'zlib',
          'wordpress',
          'phpunit',
        },
      },
    },
  },
}

for name, cfg in pairs(extra_servers) do
  vim.lsp.config(name, cfg)
  vim.lsp.enable(name)
end

-- Install extra Mason tools after Lazy finishes setup to avoid conflicting
-- with the mason-tool-installer.setup call inside the upstream lspconfig config.
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyDone',
  once = true,
  callback = function()
    require('mason-tool-installer').setup {
      ensure_installed = {
        'angular-language-server',
        'typescript-language-server',
        'html-lsp',
        'css-lsp',
        'dockerfile-language-server',
        'docker-compose-language-service',
        'json-lsp',
        'yaml-language-server',
        'emmet-ls',
        'intelephense',
        'prettierd',
        'prettier',
        'jdtls',
        'vscode-spring-boot-tools',
        'java-test',
        'java-debug-adapter',
        'phpcbf',
        'hadolint',
      },
    }
  end,
})

---@module 'lazy'
---@type LazySpec
return {}
