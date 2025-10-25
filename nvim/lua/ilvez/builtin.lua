-- Disable netrw before any plugins load (required for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = "\\"

-- Disable default plugins that we don't need
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_gzip = 1
vim.g.loaded_tutor_mode_plugin = 1

-- which-key requires these to be set before plugin loads
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.opt.nu = true
vim.opt.relativenumber = false
vim.opt.laststatus = 2
vim.opt.showmatch = true
vim.opt.colorcolumn = "140"
vim.opt.signcolumn = "yes"

vim.opt.incsearch = true
vim.opt.hlsearch = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.shiftround = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.mouse = "a"

vim.opt.mousescroll = "ver:3,hor:3"
vim.opt.scrolloff = 8
vim.opt.updatetime = 500

vim.opt.clipboard = "unnamedplus"

vim.opt.title = true
vim.opt.titlestring = "%{expand('%:p:~')}"

vim.opt.list = true
vim.opt.listchars = { tab = '»·', trail = '·', eol = '¶' }
vim.api.nvim_set_hl(0, 'NonText', { ctermfg = 0, fg = 'DarkGreen' })

vim.g.rspec_command = '!bin/spring rspec {spec}'

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<C-c>', '<cmd>nohlsearch<CR>')

vim.keymap.set("n", "<C-s>", vim.cmd.w)

vim.keymap.set("n", "<c-h>", "<c-w><c-h>")
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")

vim.keymap.set("n", "<space>", "zz")
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")

vim.keymap.set("i", "$b", "binding.irb")
vim.keymap.set("i", "$B", "<% binding.irb %>")
vim.keymap.set("i", "$<", "<%  %><Left><Left><Left>")

vim.keymap.set("n", '<leader>e', ":e!<CR>", { desc = 'read current file from disc' })
vim.keymap.set("n", '<leader>n', vim.cmd.tabnew, { desc = 'new tab' })
vim.keymap.set("n", '<leader>q', vim.cmd.q, { desc = 'close buffer' })

vim.keymap.set("n", '<leader>xn', ":let @+=@%<cr>", { desc = 'copy current file path to buffer' })
vim.keymap.set("n", '<leader>xd', ':r!date "+\\%a \\%d.\\%m.\\%y \\%k:\\%M"<CR>', { desc = 'insert date & time' })
vim.keymap.set("n", '<leader>xj', ":%!jq .<CR>", { desc = 'jq the file' })

vim.keymap.set('v', '<leader>xs', '"zy:!open "https://www.google.com/search?hl=en&q=<c-r>=substitute(@z,\' \',\'%20\',\'g\')<cr>"<CR>gv', { desc = 'search selection in browser' })
vim.keymap.set('v', '<leader>xt', '"zy:!open "https://everypay.atlassian.net/browse/<c-r>=substitute(@z,\' \',\'%20\',\'g\')<cr>"<CR>gv', { desc = 'open EP jira ticket' })
vim.keymap.set('v', '<leader>xo', '"zy:!firefox "<c-r>=substitute(@z,\' \',\'%20\',\'g\')<cr>"<CR>gv', { desc = 'open in browser' })
