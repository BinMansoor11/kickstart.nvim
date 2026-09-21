-- Loaded only inside VS Code (vscode-neovim), from the end of init.lua.
-- Same keys as native Neovim, opening VS Code's own UI instead of the native-only plugins.
-- Not named vscode.lua: that would hide the extension's own `require 'vscode'` module.
-- Built into vscode-neovim already, so not mapped here: K/gh hover, gd definition, gH references,
-- gO document symbols, gc/gcc comment.
-- Still real plugins in VS Code (see the allow-list in init.lua), so also not mapped here:
-- mini.nvim (<leader>r replace-with-register, mini.ai, mini.surround) and flash.nvim (<leader><leader>s).
-- harpoon is native-only: its buffer switching does not work through vscode-neovim,
-- so VS Code's pinned tabs stand in for it below.
local vscode = require 'vscode'
local map = vim.keymap.set

-- init.lua sets 300ms; native which-key holds the leader open past that, but it doesn't load here
vim.o.timeoutlen = 1000

local function act(cmd)
  return function()
    vscode.action(cmd)
  end
end

-- Telescope keys -> VS Code pickers
map('n', '<leader>ff', act 'workbench.action.quickOpen', { desc = 'Find files' }) -- open a file by name
map('n', '<leader>fg', act 'workbench.action.findInFiles', { desc = 'Find by grep' }) -- search text in the whole project
map('n', '<leader>fw', function() -- search the word under the cursor
  vscode.action('workbench.action.findInFiles', { args = { { query = vim.fn.expand '<cword>' } } })
end, { desc = 'Find current word' })
map('n', '<leader>fs', act 'workbench.action.showCommands', { desc = 'Command palette' }) -- run any VS Code command
map('n', '<leader>fk', act 'workbench.action.openGlobalKeybindings', { desc = 'Find keymaps' }) -- list VS Code keybindings
map('n', '<leader>fd', act 'workbench.actions.view.problems', { desc = 'Find diagnostics' }) -- errors and warnings panel
map('n', '<leader>f.', act 'workbench.action.openRecent', { desc = 'Recent files' }) -- recently opened files/folders
map('n', '<leader><leader>', act 'workbench.action.showAllEditors', { desc = 'Open editors' }) -- switch between open tabs
map('n', '<leader>/', act 'actions.find', { desc = 'Find in current file' }) -- search inside this file

-- LSP keys (same as the LspAttach block in plugins.lua) -> VS Code
map('n', 'grn', act 'editor.action.rename', { desc = 'Rename' }) -- rename the symbol everywhere
map({ 'n', 'x' }, 'gra', act 'editor.action.quickFix', { desc = 'Code action' }) -- quick fix / refactor menu
map('n', 'grr', act 'editor.action.goToReferences', { desc = 'References' }) -- where is this used
map('n', 'gri', act 'editor.action.goToImplementation', { desc = 'Implementation' }) -- jump to the implementation
map('n', 'grd', act 'editor.action.revealDefinition', { desc = 'Definition' }) -- jump to the definition
map('n', 'grD', act 'editor.action.revealDeclaration', { desc = 'Declaration' }) -- jump to the declaration
map('n', 'grt', act 'editor.action.goToTypeDefinition', { desc = 'Type definition' }) -- jump to the type
map('n', 'gW', act 'workbench.action.showAllSymbols', { desc = 'Workspace symbols' }) -- search symbols in the project
map('n', '<leader>=', act 'editor.action.formatDocument', { desc = 'Format file' }) -- format the whole file (conform in native)

-- git
map('n', '<leader>gg', act 'workbench.view.scm', { desc = 'Source control' }) -- Neogit in native
map('n', '<leader>gd', act 'git.openChange', { desc = 'Git diff of this file' }) -- Diffview in native
map('n', '<leader>gD', act 'workbench.action.closeActiveEditor', { desc = 'Close git diff' }) -- closes the diff tab again
map('n', ']g', act 'workbench.action.editor.nextChange', { desc = 'Next git change' }) -- next changed hunk
map('n', '[g', act 'workbench.action.editor.previousChange', { desc = 'Previous git change' }) -- previous changed hunk

-- windows / panels
map('n', '<C-h>', act 'workbench.action.navigateLeft', { desc = 'Move focus left' }) -- focus the editor group on the left
map('n', '<C-l>', act 'workbench.action.navigateRight', { desc = 'Move focus right' }) -- focus the editor group on the right
map('n', '<C-j>', act 'workbench.action.navigateDown', { desc = 'Move focus down' }) -- focus the panel/group below
map('n', '<C-k>', act 'workbench.action.navigateUp', { desc = 'Move focus up' }) -- focus the group above
map('n', '<leader>e', act 'workbench.view.explorer', { desc = 'Explorer' }) -- neo-tree in native
map('n', '<leader>np', act 'workbench.action.toggleCenteredLayout', { desc = 'Toggle centred layout' }) -- no-neck-pain in native
map('n', '<leader>qq', act 'workbench.actions.view.problems', { desc = 'Problems' }) -- diagnostic list
map('n', '<leader>tr', act 'workbench.action.terminal.toggle', { desc = 'Terminal' }) -- toggle the terminal panel
map('n', '<leader>bd', act 'workbench.action.closeActiveEditor', { desc = 'Close buffer' }) -- :bd leaves the tab open in VS Code

-- folds: VS Code owns the folds here, Neovim knows nothing about them.
-- The extension maps these itself, but only when Neovim does not grab the key first, which is why za sometimes did nothing.
-- Mapping them explicitly always sends the VS Code command.
map('n', 'za', act 'editor.toggleFold', { desc = 'Toggle fold' }) -- open/close the fold under the cursor
map('n', 'zA', act 'editor.toggleFoldRecursively', { desc = 'Toggle fold recursively' }) -- same, with everything inside
map('n', 'zo', act 'editor.unfold', { desc = 'Open fold' }) -- open one level
map('n', 'zc', act 'editor.fold', { desc = 'Close fold' }) -- close one level
map('n', 'zR', act 'editor.unfoldAll', { desc = 'Open all folds' }) -- ufo's zR in native
map('n', 'zM', act 'editor.foldAll', { desc = 'Close all folds' }) -- ufo's zM in native
map('n', 'zv', act 'editor.unfoldRecursively', { desc = 'Reveal cursor line' }) -- open everything around the cursor

-- pinned tabs: the harpoon stand-in. Pinned tabs sit first in the tab bar and do not close by accident,
-- so <leader>1-4 lands on them the same way harpoon marks do in native Neovim.
map('n', '<leader>hh', act 'workbench.action.pinEditor', { desc = 'Pin this file' }) -- harpoon add
map('n', '<leader>hr', act 'workbench.action.unpinEditor', { desc = 'Unpin this file' }) -- harpoon remove
map('n', ']h', act 'workbench.action.nextEditorInGroup', { desc = 'Next tab' }) -- harpoon next
map('n', '[h', act 'workbench.action.previousEditorInGroup', { desc = 'Previous tab' }) -- harpoon previous
map('n', '<leader>1', act 'workbench.action.openEditorAtIndex1', { desc = 'Tab 1' }) -- first tab, usually a pinned one
map('n', '<leader>2', act 'workbench.action.openEditorAtIndex2', { desc = 'Tab 2' })
map('n', '<leader>3', act 'workbench.action.openEditorAtIndex3', { desc = 'Tab 3' })
map('n', '<leader>4', act 'workbench.action.openEditorAtIndex4', { desc = 'Tab 4' })
