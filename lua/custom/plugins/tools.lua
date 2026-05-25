local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add {
  gh 'tpope/vim-fugitive',
  gh 'sindrets/diffview.nvim',
  gh 'kdheepak/lazygit.nvim',
  gh 'crnvl96/lazydocker.nvim',
  gh 'ellisonleao/dotenv.nvim',
  gh 'harrisoncramer/gitlab.nvim',
}

-- diffview
vim.keymap.set('n', '<leader>gdo', '<cmd>DiffviewOpen<cr>',          { desc = '[G]it [D]iff [O]pen' })
vim.keymap.set('n', '<leader>gdh', '<cmd>DiffviewFileHistory %<cr>', { desc = '[G]it [D]iff file [H]istory' })
vim.keymap.set('n', '<leader>gdH', '<cmd>DiffviewFileHistory<cr>',   { desc = '[G]it [D]iff repo [H]istory' })
vim.keymap.set('n', '<leader>gdc', '<cmd>DiffviewClose<cr>',         { desc = '[G]it [D]iff [C]lose' })

-- lazydocker
require('lazydocker').setup {}
vim.keymap.set('n', '<leader>ld', function() require('lazydocker').toggle() end, { desc = 'LazyDocker' })

-- lazygit
vim.keymap.set('n', '<leader>lg', '<cmd>LazyGit<cr>', { desc = 'LazyGit' })

-- dotenv
require('dotenv').setup()
local global_env = vim.fn.stdpath 'config' .. '/.env'
if vim.fn.filereadable(global_env) == 1 then vim.cmd('Dotenv ' .. global_env) end

-- gitlab
require('gitlab').setup()
vim.keymap.set('n', '<leader>gls', function() require('gitlab').summary() end,              { desc = 'GitLab Summary' })
vim.keymap.set('n', '<leader>glr', function() require('gitlab').review() end,               { desc = 'GitLab Review' })
vim.keymap.set('n', '<leader>glA', function() require('gitlab').approve() end,              { desc = 'GitLab Approve' })
vim.keymap.set('n', '<leader>glR', function() require('gitlab').revoke() end,               { desc = 'GitLab Revoke Approval' })
vim.keymap.set('n', '<leader>glc', function() require('gitlab').create_comment() end,       { desc = 'GitLab Create Comment' })
vim.keymap.set('n', '<leader>glp', function() require('gitlab').pipeline() end,             { desc = 'GitLab Pipeline' })
vim.keymap.set('n', '<leader>gld', function() require('gitlab').toggle_discussions() end,   { desc = 'GitLab Discussions' })
