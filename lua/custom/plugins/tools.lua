---@module 'lazy'
---@type LazySpec
return {
  { 'tpope/vim-fugitive' },
  { 'sindrets/diffview.nvim' },

  {
    'crnvl96/lazydocker.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = { 'MunifTanjim/nui.nvim' },
    keys = {
      { '<leader>ld', "<cmd>lua require('lazydocker').toggle()<CR>", desc = 'LazyDocker' },
    },
  },

  {
    'kdheepak/lazygit.nvim',
    cmd = { 'LazyGit', 'LazyGitConfig', 'LazyGitCurrentFile', 'LazyGitFilter', 'LazyGitFilterCurrentFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = 'LazyGit' },
    },
  },

  {
    'ellisonleao/dotenv.nvim',
    config = function()
      require('dotenv').setup()
      local global_env = vim.fn.stdpath 'config' .. '/.env'
      if vim.fn.filereadable(global_env) == 1 then vim.cmd('Dotenv ' .. global_env) end
    end,
  },

  {
    'harrisoncramer/gitlab.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
      'stevearc/dressing.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    enabled = true,
    build = function() require('gitlab.server').build(true) end,
    config = function() require('gitlab').setup() end,
    keys = {
      { '<leader>gls', "<cmd>lua require('gitlab').summary()<CR>",           desc = 'GitLab Summary' },
      { '<leader>glr', "<cmd>lua require('gitlab').review()<CR>",             desc = 'GitLab Review' },
      { '<leader>glA', "<cmd>lua require('gitlab').approve()<CR>",            desc = 'GitLab Approve' },
      { '<leader>glR', "<cmd>lua require('gitlab').revoke()<CR>",             desc = 'GitLab Revoke Approval' },
      { '<leader>glc', "<cmd>lua require('gitlab').create_comment()<CR>",     desc = 'GitLab Create Comment' },
      { '<leader>glp', "<cmd>lua require('gitlab').pipeline()<CR>",           desc = 'GitLab Pipeline' },
      { '<leader>gld', "<cmd>lua require('gitlab').toggle_discussions()<CR>", desc = 'GitLab Discussions' },
    },
  },
}
