---@module 'lazy'
---@type LazySpec
return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  lazy = false,
  keys = {
    { '-', '<cmd>Oil<cr>', desc = 'Open parent directory (Oil)' },
  },
  opts = {
    default_file_explorer = false,
    view_options = {
      show_hidden = true,
    },
  },
}
