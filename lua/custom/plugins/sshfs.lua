local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'uhs-robert/sshfs.nvim' }

require('sshfs').setup {
  ui = {
    local_picker = {
      preferred_picker = 'neo-tree',
    },
  },
}
