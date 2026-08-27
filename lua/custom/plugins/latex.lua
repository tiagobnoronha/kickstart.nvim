local function gh(repo) return 'https://github.com/' .. repo end

vim.pack.add { gh 'lervag/vimtex' }

vim.g.vimtex_view_method = 'skim'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_mappings_enabled = 1

vim.keymap.set('n', '<leader>lc', '<cmd>VimtexCompile<cr>',   { desc = '[L]aTeX [C]ompile (toggle)' })
vim.keymap.set('n', '<leader>lv', '<cmd>VimtexView<cr>',      { desc = '[L]aTeX [V]iew PDF' })
vim.keymap.set('n', '<leader>le', '<cmd>VimtexErrors<cr>',    { desc = '[L]aTeX [E]rrors' })
vim.keymap.set('n', '<leader>lk', '<cmd>VimtexClean<cr>',     { desc = '[L]aTeX [K]lean aux files' })
vim.keymap.set('n', '<leader>lt', '<cmd>VimtexTocToggle<cr>', { desc = '[L]aTeX [T]oc' })
