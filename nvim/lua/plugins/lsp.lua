return {
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'Mason' },
    dependencies = {
      'mason-org/mason.nvim',
      'mason-org/mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          "lua_ls",
          "pylsp",
          "ruff",
          "ts_ls",
          "vue_ls",
          "solargraph",
          "eslint",
        },
      })

      vim.diagnostic.config({
        virtual_text = {
          spacing = 4,
          prefix = '●',
        },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN] = '▲',
            [vim.diagnostic.severity.HINT] = '⚑',
            [vim.diagnostic.severity.INFO] = '»',
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = true,
          header = '',
          prefix = '',
        },
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          local opts = { buffer = bufnr, remap = false }

          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', function() vim.lsp.buf.hover({ border = 'rounded' }) end, opts)
          vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
          vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, opts)
          vim.keymap.set('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, opts)
          vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
          vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
          vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help({ border = 'rounded' }) end, opts)
          vim.keymap.set('n', '<leader>m', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>f', vim.diagnostic.setloclist, opts)

          if client and client:supports_method('textDocument/inlayHint') then
            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
            vim.keymap.set('n', '<leader>vh', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
            end, { buffer = bufnr, desc = 'Toggle inlay hints' })
          end
        end,
      })

      vim.lsp.config.lua_ls = { capabilities = capabilities }

      vim.lsp.config.pylsp = { capabilities = capabilities }
      vim.lsp.config.ruff = { capabilities = capabilities }

      vim.lsp.config.solargraph = {
        capabilities = capabilities,
        settings = {
          solargraph = {
            autoformat = false,
            formatting = false,
            folding = false,
          }
        }
      }
      vim.lsp.config.rubocop = {
        cmd = { 'bundle', 'exec', 'rubocop', '--lsp' },
        capabilities = capabilities,
      }

      local vue_language_server_path = vim.fn.stdpath('data') .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"
      local vue_plugin = {
        name = '@vue/typescript-plugin',
        location = vue_language_server_path,
        languages = { 'vue' },
        configNamespace = 'typescript',
      }
      vim.lsp.config.ts_ls = {
        init_options = { plugins = { vue_plugin } },
        filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
        capabilities = capabilities,
      }
      vim.lsp.config.vue_ls = { capabilities = capabilities }
      vim.lsp.config.eslint = {
        cmd = { 'vscode-eslint-language-server', '--stdio' },
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue' },
        root_markers = { 'eslint.config.js', 'package.json' },
        capabilities = capabilities,
      }

      vim.lsp.enable({
        'lua_ls',
        'pylsp',
        'ruff',
        'ts_ls',
        'vue_ls',
        'solargraph',
        'rubocop',
        'eslint',
      })
    end
  },
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'windwp/nvim-autopairs',
    },
    event = 'InsertEnter',
    config = function()
      local cmp = require('cmp')
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        formatting = {
          fields = { 'menu', 'abbr', 'kind' },
          format = function(entry, item)
            local menu_icon = {
              nvim_lsp = 'λ',
              luasnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
            }
            item.menu = menu_icon[entry.source.name]
            return item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete(),
        }),
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        }
      })
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end
  },
}
