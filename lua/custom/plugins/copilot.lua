return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        auto_refresh = true,
        layout = {
          position = 'right',
          ratio = 0.2,
        },
      },
      suggestion = {
        accept = false,
        auto_trigger = true,
      },
    }
  end,
}
