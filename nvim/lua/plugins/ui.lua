function LightlineFilename()
  local filename = vim.fn.expand("%:t")
  filename = filename ~= "" and filename or "[No Name]"
  local modified = vim.bo.modified and " +" or ""
  return filename .. modified
end

return {
  {
    'scottmckendry/cyberdream.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
        transparent = false,
        italic_comments = false,
        hide_fillchars = true,
        borderless_pickers = false,
        terminal_colors = true,
      })
      vim.cmd.colorscheme("cyberdream")

      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#2a2a2a' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = '#2a2a2a', fg = '#7a7a7a' })
    end
  },

  {
    'itchyny/lightline.vim',
    lazy = false,
    priority = 900,
    config = function()
      vim.g.lightline = {
        colorscheme = 'wombat',
        active = {
          left = {
            { 'mode', 'paste' },
            { 'readonly', 'filename', 'modified' }
          },
          right = {
            { 'lineinfo' },
            { 'percent' },
            { 'charvaluehex', 'fileformat', 'fileencoding', 'filetype' }
          }
        },
        component = {
          charvaluehex = '0x%B'
        },
        component_function = {
          extended_filename = 'LightlineFilename'
        },
        mode_map = {
          n = 'N',
          i = 'I',
          R = 'R',
          v = 'V',
          V = 'VL',
          ["\x1c"] = 'VB',
          c = 'C',
          s = 'S',
          S = 'SL',
          ["\x13"] = 'SB',
          t = 'T'
        }
      }
    end
  },

  {
    'folke/which-key.nvim',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      'echasnovski/mini.icons',
    },
    event = 'VeryLazy',
    config = function()
      require('which-key').setup {}

      local wk = require("which-key")
      wk.add({
        { '<leader>v', group = 'git versioning' },
        { '<leader>s', group = 'spec actions' },
        { '<leader>t', group = 'random telescope' },
        { '<leader>r', group = 'ripgrep' },
        { '<leader>x', group = 'random utils' }
      })
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    cmd = { 'NvimTreeToggle', 'NvimTreeFindFile' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'NvimTree toggle' },
      { '<C-n>', '<cmd>NvimTreeFindFile<CR>', desc = 'focus file in NvimTree' },
    },
    config = function()
      require('nvim-tree').setup({
        update_focused_file = {
          enable = true,
          update_root = false,
        },
        sort = {
          sorter = 'case_sensitive',
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = 'BufReadPre',
    config = function()
      require('ibl').setup({ indent = { char = '┊', }, })
    end
  },
}
