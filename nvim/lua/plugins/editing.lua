return {
  {
    'tpope/vim-commentary',
    event = 'BufReadPost'
  },
  {
    'tpope/vim-surround',
    event = 'BufReadPost'
  },
  {
    'AndrewRadev/splitjoin.vim',
    event = 'BufReadPost'
  },
  {
    url = 'https://git.sr.ht/~foosoft/argonaut.nvim',
    cmd = { 'ArgonautToggle', 'ArgonautReflow' },
    keys = {
      { '<leader>a', '<cmd>ArgonautToggle<cr>', desc = 'argument wrapping toggle' },
    },
    config = function()
      require('argonaut').setup({
        brace_last_wrap = true,
        comma_last = true,
      })
    end
  },
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
  },
  {
    'mbbill/undotree',
    cmd = 'UndotreeToggle',
    keys = {
      { '<leader>u', vim.cmd.UndotreeToggle, desc = 'undotree toggle' },
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = function()
      require('nvim-autopairs').setup({})
    end
  },
  {
    'Wansmer/sibling-swap.nvim',
    dependencies = { 'nvim-treesitter' },
    keys = {
      { 'g<', function() require('sibling-swap').swap_with_left() end, desc = 'swap with previous sibling' },
      { 'g>', function() require('sibling-swap').swap_with_right() end, desc = 'swap with next sibling' },
      { '<leader><', function() require('sibling-swap').swap_with_left_with_opp() end, desc = 'swap left with operator inversion' },
      { '<leader>>', function() require('sibling-swap').swap_with_right_with_opp() end, desc = 'swap right with operator inversion' },
    },
    config = function()
      require('sibling-swap').setup({
        use_default_keymaps = false,
      })
    end
  },
  {
    'ntpeters/vim-better-whitespace',
    event = 'BufReadPost'
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          ruby = { 'rubocop' },
          python = { 'ruff_organize_imports', 'ruff_fix', 'ruff_format' },
        },
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>vf', function()
        require('conform').format({ lsp_fallback = true, async = false, timeout_ms = 5000 })
      end, { desc = 'Format file or selection' })
    end
  },
}
