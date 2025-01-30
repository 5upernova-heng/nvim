return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', 'folke/tokyonight.nvim' },
  config = function()
    local colors = require('tokyonight.colors').setup()
    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = '|',
        section_separators = '|',
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
        ignore_focus = {},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = {
          statusline = 100,
          tabline = 100,
          winbar = 100,
        },
      },
      sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            'mode',
            fmt = function(str)
              return str:sub(1, 1)
            end,
            color = function()
              -- auto change color according to neovims mode
              local mode_color = {
                n = colors.blue,
                i = colors.green,
                v = colors.blue,
                [''] = colors.blue,
                V = colors.magenta,
                c = colors.magenta,
                no = colors.red,
                s = colors.orange,
                S = colors.orange,
                [''] = colors.orange,
                ic = colors.yellow,
                R = colors.orange,
                Rv = colors.orange,
                cv = colors.red,
                ce = colors.red,
                r = colors.cyan,
                rm = colors.cyan,
                ['r?'] = colors.cyan,
                ['!'] = colors.red,
                t = colors.red,
              }
              return { fg = colors.black, bg = mode_color[vim.fn.mode()], gui = 'bold' }
            end,
          },
          'branch',
          'diff',
          'diagnostics',
          {
            function()
              local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
              local clients = vim.lsp.get_clients()
              if next(clients) == nil then
                return 'No Active Lsp'
              end
              local msg = ''
              for _, client in ipairs(clients) do
                ---@diagnostic disable-next-line: undefined-field
                local filetypes = client.config.filetypes
                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                  if msg == '' then
                    msg = client.name
                  else
                    msg = msg .. ' + ' .. client.name
                  end
                end
              end
              return msg
            end,
            icon = ' LSP:',
            color = { fg = '#ffffff', gui = 'italic' },
          },
        },
        lualine_x = { 'location', 'encoding', 'fileformat', 'filetype' },
        lualine_y = {},
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
    }
  end,
}
