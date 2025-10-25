return {
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
          {
            pattern = "src/registry_agent/(.*)/.*.py$",
            target = "tests/%1/test_%1.py",
            context = "tests",
          }
        }
      })
    end
  },
}
