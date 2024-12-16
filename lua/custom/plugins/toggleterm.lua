return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {--[[ things you want to change go here]]
    },
    config = function()
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        hide_numbers = true,
      }
    end,
  },
}
