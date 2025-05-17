return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cond = function()
    return not vim.g.vscode
  end,
  opts = { signs = true },
}
