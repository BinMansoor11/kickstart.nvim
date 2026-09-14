-- Loaded only inside VS Code (vscode-neovim), from the end of init.lua.
-- Same keys as native Neovim, opening VS Code's own UI instead of the native-only plugins.
-- Not named vscode.lua: that would hide the extension's own `require 'vscode'` module.
-- Built into vscode-neovim already, so not mapped here: K/gh hover, gd definition, gH references,
-- gO document symbols, gc/gcc comment, zc/zo/za/zM/zR folds.
local vscode = require 'vscode'
local map = vim.keymap.set

local function act(cmd)
  return function()
    vscode.action(cmd)
  end
end

-- Telescope keys -> VS Code pickers
map('n', '<leader>ff', act 'workbench.action.quickOpen', { desc = 'Find files' })
map('n', '<leader>fg', act 'workbench.action.findInFiles', { desc = 'Find by grep' })
map('n', '<leader>fw', function()
  vscode.action('workbench.action.findInFiles', { args = { { query = vim.fn.expand '<cword>' } } })
end, { desc = 'Find current word' })
map('n', '<leader>fs', act 'workbench.action.showCommands', { desc = 'Command palette' })
map('n', '<leader>fk', act 'workbench.action.openGlobalKeybindings', { desc = 'Find keymaps' })
map('n', '<leader>fd', act 'workbench.actions.view.problems', { desc = 'Find diagnostics' })
map('n', '<leader>f.', act 'workbench.action.openRecent', { desc = 'Recent files' })
map('n', '<leader><leader>', act 'workbench.action.showAllEditors', { desc = 'Open editors' })
map('n', '<leader>/', act 'actions.find', { desc = 'Find in current file' })

-- LSP keys (same as the LspAttach block in plugins.lua) -> VS Code
map('n', 'grn', act 'editor.action.rename', { desc = 'Rename' })
map({ 'n', 'x' }, 'gra', act 'editor.action.quickFix', { desc = 'Code action' })
map('n', 'grr', act 'editor.action.goToReferences', { desc = 'References' })
map('n', 'gri', act 'editor.action.goToImplementation', { desc = 'Implementation' })
map('n', 'grd', act 'editor.action.revealDefinition', { desc = 'Definition' })
map('n', 'grD', act 'editor.action.revealDeclaration', { desc = 'Declaration' })
map('n', 'grt', act 'editor.action.goToTypeDefinition', { desc = 'Type definition' })
map('n', 'gW', act 'workbench.action.showAllSymbols', { desc = 'Workspace symbols' })
map('n', '<leader>=', act 'editor.action.formatDocument', { desc = 'Format file' })

-- git
map('n', '<leader>gg', act 'workbench.view.scm', { desc = 'Source control' })
map('n', '<leader>gd', act 'git.openChange', { desc = 'Git diff of this file' })
map('n', ']g', act 'workbench.action.editor.nextChange', { desc = 'Next git change' })
map('n', '[g', act 'workbench.action.editor.previousChange', { desc = 'Previous git change' })

-- windows / panels
map('n', '<C-h>', act 'workbench.action.navigateLeft', { desc = 'Move focus left' })
map('n', '<C-l>', act 'workbench.action.navigateRight', { desc = 'Move focus right' })
map('n', '<C-j>', act 'workbench.action.navigateDown', { desc = 'Move focus down' })
map('n', '<C-k>', act 'workbench.action.navigateUp', { desc = 'Move focus up' })
map('n', '<leader>e', act 'workbench.view.explorer', { desc = 'Explorer' })
map('n', '<leader>np', act 'workbench.action.toggleCenteredLayout', { desc = 'Toggle centred layout' })
map('n', '<leader>qq', act 'workbench.actions.view.problems', { desc = 'Problems' })
map('n', '<leader>tr', act 'workbench.action.terminal.toggle', { desc = 'Terminal' })
