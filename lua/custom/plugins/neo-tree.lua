local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'nvim-neo-tree/neo-tree.nvim' }

require('neo-tree').setup {
  default_component_configs = {
    icon = {
      provider = function(icon, node)
        if node.type == 'file' then
          local name = node.name
          if name:match '^compose%..*%.ya?ml$' or name:match '^docker%-compose%..*%.ya?ml$' then
            local ok, devicons = pcall(require, 'nvim-web-devicons')
            if ok then
              local devicon, hl = devicons.get_icon 'docker-compose.yml'
              icon.text = devicon or icon.text
              icon.highlight = hl or icon.highlight
            end
            return
          end
          local ok, devicons = pcall(require, 'nvim-web-devicons')
          if ok then
            local devicon, hl = devicons.get_icon(name)
            icon.text = devicon or icon.text
            icon.highlight = hl or icon.highlight
          end
        end
      end,
    },
  },
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
}

vim.keymap.set('n', '\\', ':Neotree reveal<CR>', { desc = 'NeoTree reveal', silent = true })
