vim.cmd 'filetype plugin indent on'
-- See `:help mapleader`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Netrew disabled globally
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- personal configs
local function set_transparent()
  vim.cmd [[
    hi Normal ctermbg=none guibg=none
    hi NormalNC ctermbg=none guibg=none
    hi SignColumn ctermbg=none guibg=none
    hi LineNr ctermbg=none guibg=none
    hi EndOfBuffer ctermbg=none guibg=none
    hi VertSplit ctermbg=none guibg=none
    ]]
end

-- Keymaps in Lua
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ThePrimeagen remaps
map('n', '<leader>pv', vim.cmd.Ex)
vim.opt.syntax = 'on'
vim.opt.hidden = true -- Enable background buffers
vim.opt.hlsearch = false

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true

vim.opt.number = true
vim.opt.relativenumber = true

-- Save, quit, and save+quit
map('n', '<leader>s', ':w<CR>', opts)
map('n', '<leader>x', ':x<CR>', opts)
map('n', '<leader>bd', ':bd<CR>', opts)

-- Scroll and movement bindings
map('n', 'J', 'mzJ`z', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)
map('n', '<leader>e', '<C-e>', opts)
map('n', '<leader>y', '<C-y>', opts)

-- Redo
map('n', '<leader>r', '<C-r>', opts)

-- INSERT MODE bindings
map('i', 'jj', '<Esc>', opts)

-- COMMANDS
map('n', '<leader>mv', ':e $MYVIMRC<CR>', opts)
map('v', 'J', ":m '>+1<CR>gv=gv")
map('v', 'K', ":m '<-2<CR>gv=gv")
map('n', 'Q', '<nop>')

-- Apply transparency on startup
set_transparent()

-- Reapply after changing colorscheme
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = set_transparent,
})

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'ci'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 3

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- [[ Basic Keymaps ]]

-- Clear highlights on search when pressing <Esc> in normal mode
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '<leader>qq', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- map("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- map("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- map("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- map("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- nvim treesitter-context

map('n', '[c', function()
  require('treesitter-context').go_to_context(vim.v.count1)
end, { silent = true })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Ignore patterns globally (for Telescope, :find, etc.)
vim.opt.wildignore:append {
  '**/.next/*',
  '**/dist/*',
  '**/node_modules/*',
}

-- Also ignore in file completion
vim.opt.wildignorecase = true

-- For Telescope specifically
local ok, telescope = pcall(require, 'telescope')
if ok then
  telescope.setup {
    defaults = {
      file_ignore_patterns = { 'node_modules', '%.next', 'dist' },
    },
  }
end
local augroup = vim.api.nvim_create_augroup('JSFoldsGroup', { clear = true })

function _G.JSFolds()
  local line = vim.fn.getline(vim.v.lnum)

  if line:match '^%s*$' then
    return '-1'
  end

  if line:match '^import.*$' then
    return 1
  else
    return vim.fn.indent(vim.v.lnum) / vim.bo.shiftwidth
  end
end

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = {
    'javascript', -- .js
    'javascriptreact', -- .jsx
    'typescript', -- .ts
    'typescriptreact', -- .tsx
  },
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldexpr = 'v:lua.JSFolds()'
  end,
})

-- 👇 After buffer loads, close only import folds
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
  callback = function()
    vim.schedule(function()
      vim.cmd 'silent! g/^import/normal! zc'
    end)
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup('plugins', {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- nvim treesitter context background cursor line transparency, running after colortheme
vim.cmd [[
  highlight clear TreesitterContext
  highlight TreesitterContext guibg=NONE guifg=#FFFFFF
]]

-- -- cursor line color
-- vim.api.nvim_set_hl(0, 'CursorLine', { bg = '#421D3A' }) -- Standard magenta

-- -- Use your terminal's magenta with transparency effect
-- local shades = {
--   -- Section order: Mode, Filename, Fileinfo, Location
--   MiniStatuslineModeNormal = { bg = '#7C3A6C', fg = '#FFFFFF', bold = true },
--   MiniStatuslineModeInsert = { bg = '#6E3360', fg = '#FFFFFF' },
--   MiniStatuslineModeVisual = { bg = '#5A2B4F', fg = '#FFFFFF' },
--   MiniStatuslineModeReplace = { bg = '#2D1428', fg = '#FFFFFF' },
--   MiniStatuslineModeCommand = { bg = '#6E3360', fg = '#FFFFFF' },
--   MiniStatuslineModeOther = { bg = '#2D1428', fg = '#E0E0E0' },
--   MiniStatuslineFilename = { bg = '#421D3A', fg = '#E0E0E0', bold = true },
--   MiniStatuslineFileinfo = { bg = '#5A2B4F', fg = '#C0C0C0' },
--   MiniStatuslineLocation = { bg = '#2D1428', fg = '#FFFFFF', bold = true },
-- }

-- Statusline colors for Dark+ with background image opacity (Black Matte theme)
local shades = {
  -- Section order: Mode, Filename, Fileinfo, Location
  MiniStatuslineModeNormal = { bg = '#2A2A2A', fg = '#FFFFFF', bold = true },
  MiniStatuslineModeInsert = { bg = '#3A3A3A', fg = '#FFFFFF' },
  MiniStatuslineModeVisual = { bg = '#404040', fg = '#FFFFFF' },
  MiniStatuslineModeReplace = { bg = '#1A1A1A', fg = '#FFFFFF' },
  MiniStatuslineModeCommand = { bg = '#3A3A3A', fg = '#FFFFFF' },
  MiniStatuslineModeOther = { bg = '#1A1A1A', fg = '#D0D0D0' },
  MiniStatuslineFilename = { bg = '#222222', fg = '#E8E8E8', bold = true },
  MiniStatuslineFileinfo = { bg = '#333333', fg = '#B0B0B0' },
  MiniStatuslineLocation = { bg = '#1A1A1A', fg = '#FFFFFF', bold = true },
}

for group, _opts in pairs(shades) do
  vim.api.nvim_set_hl(0, group, _opts)
end

-- Keep statusline background transparent for your background image
vim.api.nvim_set_hl(0, 'StatusLine', { bg = 'NONE' })
vim.api.nvim_set_hl(0, 'StatusLineNC', { bg = 'NONE' })
