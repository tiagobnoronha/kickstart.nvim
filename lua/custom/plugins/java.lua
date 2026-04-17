local function java_infer_package(dir)
  for _, pat in ipairs({ 'src/main/java/', 'src/test/java/' }) do
    local _, finish = dir:find(pat, 1, true)
    if finish then
      return dir:sub(finish + 1):gsub('/', '.'):gsub('%.$', '')
    end
  end
  return ''
end

local function java_get_target_dir()
  if vim.bo.filetype == 'neo-tree' then
    local ok, manager = pcall(require, 'neo-tree.sources.manager')
    if ok then
      local state = manager.get_state_for_window()
      if state and state.tree then
        local node = state.tree:get_node()
        if node then
          local path = node:get_id()
          return node.type == 'directory' and path or vim.fn.fnamemodify(path, ':h')
        end
      end
    end
    return vim.fn.getcwd()
  end
  local bufname = vim.api.nvim_buf_get_name(0)
  if bufname ~= '' then
    local candidate = vim.fn.fnamemodify(bufname, ':p:h')
    return vim.uv.fs_stat(candidate) and candidate or vim.fn.getcwd()
  end
  return vim.fn.getcwd()
end

local function java_create_file(kind)
  vim.ui.input({ prompt = 'Java ' .. kind .. ' name: ' }, function(name)
    if not name or name == '' then return end

    local dir = java_get_target_dir()

    local filepath = dir .. '/' .. name .. '.java'
    if vim.uv.fs_stat(filepath) then
      vim.notify('File already exists: ' .. filepath, vim.log.levels.ERROR)
      return
    end

    local pkg = java_infer_package(dir)
    local lines = {}
    if pkg ~= '' then
      lines[#lines + 1] = 'package ' .. pkg .. ';'
      lines[#lines + 1] = ''
    end
    if kind == 'class' then
      lines[#lines + 1] = 'public class ' .. name .. ' {'
    elseif kind == 'interface' then
      lines[#lines + 1] = 'public interface ' .. name .. ' {'
    elseif kind == 'record' then
      lines[#lines + 1] = 'public record ' .. name .. '() {'
    end
    lines[#lines + 1] = '}'
    lines[#lines + 1] = ''

    local ok, err = pcall(vim.fn.writefile, lines, filepath)
    if not ok then
      vim.notify('Failed to create file: ' .. tostring(err), vim.log.levels.ERROR)
      return
    end

    vim.cmd('edit ' .. vim.fn.fnameescape(filepath))
    local body_line = (pkg ~= '') and 4 or 2
    vim.api.nvim_win_set_cursor(0, { body_line, 0 })
  end)
end

vim.keymap.set('n', '<leader>jnc', function() java_create_file 'class'     end, { desc = 'Java: [N]ew [C]lass' })
vim.keymap.set('n', '<leader>jni', function() java_create_file 'interface' end, { desc = 'Java: [N]ew [I]nterface' })
vim.keymap.set('n', '<leader>jnr', function() java_create_file 'record'    end, { desc = 'Java: [N]ew [R]ecord' })

---@module 'lazy'
---@type LazySpec
return {
  { 'mfussenegger/nvim-jdtls' },
  {
    'folke/which-key.nvim',
    optional = true,
    opts = {
      spec = {
        { '<leader>jn', group = 'Java [N]ew file' },
      },
    },
  },
}
