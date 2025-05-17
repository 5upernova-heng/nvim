return {
  'lewis6991/gitsigns.nvim',
  cond = function()
    return not vim.g.vscode
  end,
  opts = {
    signs = {
      add = { text = '+' },
      change = { text = '~' },
      delete = { text = '_' },
      topdelete = { text = '‾' },
      changedelete = { text = '~' },
    },
  },
}
