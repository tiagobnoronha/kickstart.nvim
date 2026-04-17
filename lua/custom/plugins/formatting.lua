---@module 'lazy'
---@type LazySpec
return {
  {
    'stevearc/conform.nvim',
    optional = true,
    opts = {
      format_on_save = false,
      formatters_by_ft = {
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        html       = { 'prettierd', 'prettier', stop_after_first = true },
        css        = { 'prettierd', 'prettier', stop_after_first = true },
        scss       = { 'prettierd', 'prettier', stop_after_first = true },
        angular    = { 'prettierd', 'prettier', stop_after_first = true },
        php        = { 'phpcbf' },
        json       = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc      = { 'prettierd', 'prettier', stop_after_first = true },
        yaml       = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },
}
