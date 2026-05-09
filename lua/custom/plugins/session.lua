---@module 'lazy'
---@type LazySpec
return {
  'rmagatti/auto-session',
  lazy = false,
  keys = {
    { '<leader>Ss', '<cmd>SessionSave<cr>',   desc = '[S]ession [S]ave' },
    { '<leader>Sf', '<Cmd>SessionSearch<CR>', desc = '[S]ession [F]ind' },
    { '<leader>Sd', '<cmd>SessionDelete<cr>', desc = '[S]ession [D]elete' },
  },
  opts = {
    suppressed_dirs = { '~/', '~/Downloads', '/tmp' },
    session_lens = {
      load_on_setup = true,
    },
    pre_save_cmds = { 'Neotree close' },
    post_restore_cmds = { 'Neotree show' },
  },
}
