local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'coder/claudecode.nvim' }

require('claudecode').setup {
  terminal = {
    provider = 'native',
    split_side = 'right',
    split_width_percentage = 0.35,
  },
}

vim.keymap.set('n', '<leader>cc', '<cmd>ClaudeCode<cr>',              { desc = '[C]laude [C]ode toggle' })
vim.keymap.set('n', '<leader>cf', '<cmd>ClaudeCodeFocus<cr>',         { desc = '[C]laude [F]ocus' })
vim.keymap.set('n', '<leader>ca', '<cmd>ClaudeCodeAdd<cr>',           { desc = '[C]laude [A]dd file' })
vim.keymap.set({ 'n', 'v' }, '<leader>cs', '<cmd>ClaudeCodeSend<cr>', { desc = '[C]laude [S]end selection' })
