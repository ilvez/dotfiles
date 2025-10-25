return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      'axkirillov/easypick.nvim',
    },
    cmd = { 'Telescope', 'Easypick', 'Rg' },
    keys = {
      { '<C-p>', function() require('telescope.builtin').find_files() end, desc = 'Find files' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>' },
      { '<leader>vb', ':Telescope git_branches <CR>', desc = 'git branch' },
      { '<leader>vC', '<cmd>Easypick changed_files_branch<cr>', desc = 'git changed files in branch' },
      { '<leader>vc', '<cmd>Easypick changed_files<cr>', desc = 'git changed files' },
      { '<leader>vf', function() require('telescope.builtin').git_files() end, desc = 'git ls-files' },
      { '<leader>tr', ':Telescope resume <CR>', desc = 'telescope resume' },
      { '<leader>tb', function() require('telescope.builtin').buffers() end, desc = 'telescope buffers' },
      { '<leader>rG', function() require('telescope.builtin').live_grep() end, desc = 'rg, with specs/db' },
      { '<leader>rg', function()
        require("telescope.builtin").live_grep({
          vimgrep_arguments = {
            "rg", "--color=never", "--hidden", "--no-heading", "--with-filename",
            "--line-number", "--smart-case", "--column", "--sort", "path",
            "--glob", "!{db,spec}/"
          }
        })
      end, desc = 'rg, without db/spec' },
      { '<leader>rC', function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()
      end, desc = 'rg word under cursor, with db/spec' },
      { '<leader>rc', function()
        require('telescope-live-grep-args.shortcuts').grep_word_under_cursor(
          { additional_args = { "--glob", "!{db,spec}/", "--sort", "path" } }
        )
      end, desc = 'rg word under cursor, without db/spec' },
    },
    config = function()
      require('telescope').setup {
        defaults = {
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
            '--glob',
            '!{node_modules,.git,tmp,*.class,build,.gradle,bin}'
          }
        },
        pickers = {
          find_files = {
            hidden = true
          },
          live_grep = {
            additional_args = function(_)
              return {"--hidden"}
            end
          }
        }
      }

      local ts = require('telescope')
      ts.load_extension('live_grep_args')

      local builtin = require('telescope.builtin')
      vim.api.nvim_create_user_command('Rg', function(args)
        builtin.grep_string({ hidden = true, search = args["args"] })
      end, { nargs='*' })
    end
  },
  {
    'axkirillov/easypick.nvim',
    lazy = true,
    config = function()
      local easypick = require('easypick')
      easypick.setup({
        pickers = {
          {
            name = 'changed_files',
            command = 'git diff --name-only $(git merge-base HEAD main)',
            previewer = easypick.previewers.file_diff()
          },
        }
      })
    end
  },
}
