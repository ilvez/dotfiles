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
}
