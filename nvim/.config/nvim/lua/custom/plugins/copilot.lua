return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  build = ':Copilot auth',
  opts = {
    suggestion = {
      auto_trigger = true,
      keymap = {
        accept = '<C-j>',
      },
      filetypes = {
        ['*'] = true,
      },
    },
  },
}
