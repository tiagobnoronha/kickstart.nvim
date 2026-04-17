---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
    },
    opts = {
      filesystem = {
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
        hijack_netrw_behavior = 'open_default',
      },
    },
  },
}
