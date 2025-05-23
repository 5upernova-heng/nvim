return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  cond = function()
    return not vim.g.vscode
  end,
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
      },
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'yehuohan/cmp-im',
    '5upernova-heng/cmp-im-zh',
  },
  config = function()
    -- See `:help cmp`
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local cmp_im = require 'cmp_im'
    cmp_im.setup {
      -- Enable Noice
      noice = true,
      -- Enable/Disable IM
      enable = false,
      -- IM tables path array
      tables = require('cmp_im_zh').tables { 'huge_flypy' },
      -- Function to format IM-key and IM-tex for completion display
      format = function(key, text)
        return vim.fn.printf('%-15S %s', text, key)
      end,
      -- Max number entries to show for completion of each table
      maxn = 8,
    }

    -- toggle cmp_im
    vim.keymap.set({ 'n', 'v', 'c', 'i' }, '<M-;>', function()
      local result = require('cmp_im').toggle()
      vim.notify(string.format('IM is %s', result and 'enabled' or 'disabled'))
      if result then
        for lhs, rhs in pairs(require('cmp_im_zh').symbols()) do
          vim.keymap.set('i', lhs, rhs)
        end
      else
        for lhs, _ in pairs(require('cmp_im_zh').symbols()) do
          vim.keymap.del('i', lhs)
        end
      end
    end)

    luasnip.config.setup {}

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      mapping = cmp.mapping.preset.insert {
        -- Select the [n]ext item
        -- ['<C-n>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        -- ['<C-p>'] = cmp.mapping.select_prev_item(),

        -- Scroll the documentation window [b]ack / [f]orward
        -- ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        -- ['<C-f>'] = cmp.mapping.scroll_docs(4),

        -- Accept ([y]es) the completion.
        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-y>'] = cmp.mapping.confirm { select = true },

        -- If you prefer more traditional completion keymaps,
        -- you can uncomment the following lines
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if require('copilot.suggestion').is_visible() then
            require('copilot.suggestion').accept()
          elseif cmp.visible() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Insert }
          elseif luasnip.expandable() then
            luasnip.expand()
          else
            fallback()
          end
        end, {
          'i',
          's',
        }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),

        -- Manually trigger a completion from nvim-cmp.
        --  Generally you don't need this, because nvim-cmp will display
        --  completions whenever it has completion options available.
        ['<C-Space>'] = cmp.mapping.complete {},

        -- Think of <c-l> as moving to the right of your snippet expansion.
        --  So if you have a snippet that's like:
        --  function $name($args)
        --    $body
        --  end
        --
        -- <c-l> will move you to the right of each of the expansion locations.
        -- <c-h> is similar, except moving you backwards.
        ['<C-l>'] = cmp.mapping(function()
          if luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          end
        end, { 'i', 's' }),
        ['<C-h>'] = cmp.mapping(function()
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          end
        end, { 'i', 's' }),

        -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
        --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
      },
      sources = {
        {
          name = 'lazydev',
          -- set group index to 0 to skip loading LuaLS completions as lazydev recommends it
          group_index = 0,
        },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'IM' },
      },
      formatting = {
        format = function(entry, vim_item)
          -- source
          local source = entry.source.name
          vim_item.menu = source

          if source == 'nvim_lsp' then
            local lspserver_name = nil
            pcall(function()
              lspserver_name = entry.source.source.client.name
              vim_item.menu = lspserver_name
            end)
          end

          return vim_item
        end,
      },
    }
  end,
}
