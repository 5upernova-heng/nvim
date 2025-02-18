return {
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {--[[ things you want to change go here]]
    },
    config = function()
      -- vim.opt.shell = 'zsh'
      -- if vim.fn.has 'win64' then
      --   vim.opt.shell = vim.fn.executable 'pwsh' and 'pwsh' or 'powershell'
      --   vim.opt.shellcmdflag =
      --     '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
      --   vim.opt.shellredir = '-RedirectStandardOutput %s -NoNewWindow -Wait'
      --   vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
      --   vim.opt.shellquote = ''
      --   vim.opt.shellxquote = ''
      -- end
      require('toggleterm').setup {
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        direction = 'float',
      }
    end,
  },
}
