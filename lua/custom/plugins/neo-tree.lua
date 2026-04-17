---@module 'lazy'
---@type LazySpec
return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    optional = true,
    opts = {
      filesystem = {
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        hijack_netrw_behavior = 'open_default',
      },
    },
  },
}
