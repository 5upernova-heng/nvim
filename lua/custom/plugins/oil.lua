return {
  'stevearc/oil.nvim',
  opts = {},
  cond = function()
    return not vim.g.vscode
  end,
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
    }
  end,
  vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent folder' }),
}
