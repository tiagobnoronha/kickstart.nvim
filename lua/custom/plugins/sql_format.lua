vim.keymap.set('v', '<leader>fs', function()
  local start_line = vim.fn.line "'<"
  local end_line = vim.fn.line "'>"
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  if #lines == 0 then return end

  local indent = lines[1]:match '^(%s*)' or ''

  local stripped = {}
  for _, line in ipairs(lines) do
    table.insert(stripped, line:sub(#indent + 1))
  end

  local result = vim.fn.system('sql-formatter -l plsql', table.concat(stripped, '\n'))

  if vim.v.shell_error ~= 0 then
    vim.notify('sql-formatter failed:\n' .. result, vim.log.levels.ERROR)
    return
  end

  local output_lines = vim.split(result, '\n', { plain = true })
  while #output_lines > 0 and output_lines[#output_lines] == '' do
    table.remove(output_lines)
  end

  local indented = {}
  for _, line in ipairs(output_lines) do
    table.insert(indented, indent .. line)
  end

  vim.api.nvim_buf_set_lines(0, start_line - 1, end_line, false, indented)
end, { desc = '[F]ormat [S]QL selection' })

---@module 'lazy'
---@type LazySpec
return {}
