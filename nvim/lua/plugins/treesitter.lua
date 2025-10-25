return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = {
      'RRethy/nvim-treesitter-endwise',
    },
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = {
          "bash",
          "c",
          "dockerfile",
          "java",
          "json",
          "kotlin",
          "lua",
          "markdown",
          "markdown_inline",
          "query",
          "ruby",
          "rust",
          "vim",
          "vimdoc",
          "xml",
          "html",
          "python",
          "javascript",
          "typescript",
        },

        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          disable = {"markdown", "markdown_inline", "json"},
          additional_vim_regex_highlighting = false
        },
        endwise = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
        },
        matchup = {
          enable = true
        }
      }
    end
  },
}
