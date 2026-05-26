vim.filetype.add {
  pattern = {
    ['.*%.html'] = function(path)
      if path:match('%.component%.html$') then return 'htmlangular' end
      local base = path:match('^(.+)%.html$')
      if base and vim.uv.fs_stat(base .. '.ts') then return 'htmlangular' end
    end,
  },
}

-- Old Angular pattern: foo.component.ts / foo.component.html / ...
-- New Angular v20 pattern: foo.ts / foo.html / foo.scss / foo.spec.ts
-- .spec.ts must come before .ts in each list to avoid false suffix match
local old_extensions = {
  { ext = '.component.ts',      role = 'ts'   },
  { ext = '.component.html',    role = 'html' },
  { ext = '.component.scss',    role = 'scss' },
  { ext = '.component.spec.ts', role = 'spec' },
}

local new_extensions = {
  { ext = '.spec.ts', role = 'spec' },
  { ext = '.ts',      role = 'ts'   },
  { ext = '.html',    role = 'html' },
  { ext = '.scss',    role = 'scss' },
}

local function get_context()
  local current = vim.api.nvim_buf_get_name(0)
  for _, exts in ipairs { old_extensions, new_extensions } do
    for i, entry in ipairs(exts) do
      if vim.endswith(current, entry.ext) then
        return current:sub(1, #current - #entry.ext), exts, i
      end
    end
  end
  return nil, nil, nil
end

local function angular_goto_role(role)
  local base, exts = get_context()
  if not base then
    vim.notify('Not an Angular file', vim.log.levels.WARN)
    return
  end
  for _, entry in ipairs(exts) do
    if entry.role == role then
      local target = base .. entry.ext
      if vim.uv.fs_stat(target) then
        vim.cmd('edit ' .. vim.fn.fnameescape(target))
      else
        vim.notify('File not found: ' .. target, vim.log.levels.WARN)
      end
      return
    end
  end
end

local function angular_cycle()
  local base, exts, idx = get_context()
  if not base then
    vim.notify('Not an Angular file', vim.log.levels.WARN)
    return
  end
  local next_entry = exts[(idx % #exts) + 1]
  local target = base .. next_entry.ext
  if vim.uv.fs_stat(target) then
    vim.cmd('edit ' .. vim.fn.fnameescape(target))
  else
    vim.notify('File not found: ' .. target, vim.log.levels.WARN)
  end
end

vim.keymap.set('n', '<leader>aa', angular_cycle,                           { desc = '[A]ngular cycle files' })
vim.keymap.set('n', '<leader>ac', function() angular_goto_role 'ts' end,   { desc = '[A]ngular [C]omponent TS' })
vim.keymap.set('n', '<leader>at', function() angular_goto_role 'html' end, { desc = '[A]ngular [T]emplate HTML' })
vim.keymap.set('n', '<leader>as', function() angular_goto_role 'scss' end, { desc = '[A]ngular [S]tylesheet SCSS' })
vim.keymap.set('n', '<leader>aS', function() angular_goto_role 'spec' end, { desc = '[A]ngular [S]pec TS' })

vim.lsp.config('angularls', {
  filetypes = { 'typescript', 'html', 'typescriptreact', 'htmlangular' },
})
vim.lsp.enable 'angularls'

vim.lsp.config('html', {
  on_attach = function(client, bufnr)
    if vim.bo[bufnr].filetype == 'htmlangular' then client.stop() end
  end,
})
vim.lsp.enable 'html'
