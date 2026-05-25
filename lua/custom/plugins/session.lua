local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'rmagatti/auto-session' }

require('auto-session').setup {
  suppressed_dirs = { '~/', '~/Downloads', '/tmp' },
  session_lens = {
    load_on_setup = true,
  },
  pre_save_cmds = { 'Neotree close' },
  post_restore_cmds = { 'Neotree show' },
}

vim.keymap.set('n', '<leader>Ss', '<cmd>SessionSave<cr>',   { desc = '[S]ession [S]ave' })
vim.keymap.set('n', '<leader>Sf', '<Cmd>SessionSearch<CR>', { desc = '[S]ession [F]ind' })
vim.keymap.set('n', '<leader>Sd', '<cmd>SessionDelete<cr>', { desc = '[S]ession [D]elete' })
