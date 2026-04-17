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
      default_component_configs = {
        icon = {
          provider = function(icon, node)
            if node.type == 'file' then
              -- Docker Compose variants not covered by nvim-web-devicons exact filename match
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
              -- Default: delegate to nvim-web-devicons
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
    },
  },
}
