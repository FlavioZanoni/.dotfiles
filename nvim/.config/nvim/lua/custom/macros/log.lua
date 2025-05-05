local esc = vim.api.nvim_replace_termcodes('<Esc>', true, true, true)

vim.api.nvim_create_augroup('JSLog-Macro', { clear = true })

vim.api.nvim_create_autocmd('FileType', {
  group = 'JSLog-Macro',
  pattern = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' },
  callback = function()
    vim.fn.setreg('l', 'yoconsole.log("' .. esc .. 'pa: ", ' .. esc .. 'pi' .. esc .. 'A)')
  end,
})
