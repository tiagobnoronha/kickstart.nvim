local bufnr = nil

local function find_win(buf)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == buf then
      return win
    end
  end
  return nil
end

local function open(cmd_args)
  local existing_win = bufnr and vim.api.nvim_buf_is_valid(bufnr) and find_win(bufnr)
  if existing_win then
    vim.api.nvim_set_current_win(existing_win)
    return
  end

  if bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    vim.cmd 'botright vsplit'
    vim.api.nvim_win_set_buf(0, bufnr)
  else
    -- `vnew` (not `vsplit`) so the split gets a brand-new empty buffer
    -- instead of duplicating whatever file buffer was current, which
    -- `termopen` would then convert into the terminal in place.
    vim.cmd 'botright vnew'
    vim.fn.termopen(cmd_args and ('agy ' .. cmd_args) or 'agy')
    bufnr = vim.api.nvim_get_current_buf()
    vim.bo[bufnr].bufhidden = 'hide'
  end
  vim.api.nvim_win_set_width(0, math.floor(vim.o.columns * 0.35))
  vim.cmd 'startinsert'
end

local function toggle(cmd_args)
  local win = bufnr and vim.api.nvim_buf_is_valid(bufnr) and find_win(bufnr)
  if win then
    vim.api.nvim_win_close(win, false)
  else
    open(cmd_args)
  end
end

vim.keymap.set('n', '<leader>ac', function() toggle() end, { desc = '[A]ntigravity toggle' })
vim.keymap.set('n', '<leader>ar', function() toggle '--continue' end, { desc = '[A]ntigravity [R]esume last session' })
vim.keymap.set('n', '<leader>af', function()
  local win = bufnr and vim.api.nvim_buf_is_valid(bufnr) and find_win(bufnr)
  if win then
    vim.api.nvim_set_current_win(win)
    vim.cmd 'startinsert'
  else
    open()
  end
end, { desc = '[A]ntigravity [F]ocus' })
