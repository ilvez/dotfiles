return {
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'G' },
    keys = {
      { '<leader>va', ':Git blame<CR>', desc = 'git blame', mode = 'n' },
      { '<leader>va', '<C-C>:Git blame<CR>', desc = 'git blame', mode = 'v' },
      { '<leader>va', '<C-O>:Git blame<CR>', desc = 'git blame', mode = 'i' },
    },
  },
  {
    'vim-ruby/vim-ruby',
    ft = 'ruby'
  },
  {
    'cuducos/yaml.nvim',
    ft = 'yaml',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
  },
  {
    'rgroli/other.nvim',
    cmd = { 'Other', 'OtherVSplit', 'OtherSplit' },
    keys = {
      { '<leader>.', ':Other<CR>', desc = 'switch between implementation and spec' },
      { '<leader>,', ':OtherVSplit<CR>', desc = 'switch between implementation and spec vertical' },
      { "<leader>'", ':OtherSplit<CR>', desc = 'switch between implementation and spec horizontal' },
    },
    config = function()
      require('other-nvim').setup({
        mappings = {
          "rails",
          "python",
        }
      })
    end
  },
}
