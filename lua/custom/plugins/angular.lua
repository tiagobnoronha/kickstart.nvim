vim.filetype.add {
  pattern = {
    ['.*%.component%.html'] = 'htmlangular',
  },
}

local angular_extensions = {
  { ext = '.component.ts',      label = '[C]omponent TS' },
  { ext = '.component.html',    label = '[T]emplate HTML' },
  { ext = '.component.scss',    label = '[S]tylesheet SCSS' },
  { ext = '.component.spec.ts', label = '[S]pec TS' },
}

local function angular_goto(target_ext)
  local current = vim.api.nvim_buf_get_name(0)
  local base = current
  for _, entry in ipairs(angular_extensions) do
    if vim.endswith(current, entry.ext) then
      base = current:sub(1, #current - #entry.ext)
      break
    end
  end
  local target = base .. target_ext
  if vim.uv.fs_stat(target) then
    vim.cmd('edit ' .. vim.fn.fnameescape(target))
  else
    vim.notify('File not found: ' .. target, vim.log.levels.WARN)
  end
end

local function angular_cycle()
  local current = vim.api.nvim_buf_get_name(0)
  for i, entry in ipairs(angular_extensions) do
    if vim.endswith(current, entry.ext) then
      local next = angular_extensions[(i % #angular_extensions) + 1]
      angular_goto(next.ext)
      return
    end
  end
  vim.notify('Not an Angular component file', vim.log.levels.WARN)
end

vim.keymap.set('n', '<leader>aa', angular_cycle,                                   { desc = '[A]ngular cycle files' })
vim.keymap.set('n', '<leader>ac', function() angular_goto '.component.ts' end,    { desc = '[A]ngular [C]omponent TS' })
vim.keymap.set('n', '<leader>at', function() angular_goto '.component.html' end,  { desc = '[A]ngular [T]emplate HTML' })
vim.keymap.set('n', '<leader>as', function() angular_goto '.component.scss' end,  { desc = '[A]ngular [S]tylesheet SCSS' })
vim.keymap.set('n', '<leader>aS', function() angular_goto '.component.spec.ts' end, { desc = '[A]ngular [S]pec TS' })

-- angularls: lspconfig built-in cmd handles probe locations; only override filetypes
vim.lsp.config('angularls', {
  filetypes = { 'typescript', 'html', 'typescriptreact', 'htmlangular' },
})
vim.lsp.enable 'angularls'

-- html LSP: stop on Angular template files (angularls handles them)
vim.lsp.config('html', {
  on_attach = function(client, bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == 'htmlangular' or vim.api.nvim_buf_get_name(bufnr):match '%.component%.html$' then
      client.stop()
    end
  end,
})
vim.lsp.enable 'html'

---@module 'lazy'
---@type LazySpec
return {
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>a', group = '[A]ngular' },
      },
    },
  },
}
