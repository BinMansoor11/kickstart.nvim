# CLAUDE.md

Personal Neovim config (fork of `nvim-lua/kickstart.nvim`), living at
`C:\Users\USER\AppData\Local\nvim` on Windows. Editing this repo changes the
editor that loads on next `nvim` start — a syntax error here means a broken editor.

## Layout

- `init.lua` — options, keymaps, autocmds, highlight overrides, `lazy.nvim` bootstrap.
  Ends with `require('lazy').setup('plugins', ...)`, so plugin specs come from `lua/plugins.lua`.
- `lua/plugins.lua` — the real plugin list (~1000 lines): LSP/mason, blink.cmp, telescope,
  conform, treesitter, mini.nvim, copilot, neo-tree, diffview, undotree.
- `lua/custom/plugins/init.lua` — kickstart's escape hatch, currently empty and **not loaded**
  (setup points at `plugins`, not `custom.plugins`). Add plugins to `lua/plugins.lua`.
- `lua/kickstart/plugins/*.lua` — upstream optional modules; only loaded if referenced.
- `doc/`, `.github/` — upstream leftovers, ignore.

## Conventions

- Formatting is stylua (`.stylua.toml`): 2 spaces, single quotes, 160 cols,
  `call_parentheses = "None"` — so write `require('lazy').setup 'plugins'`, not `setup('plugins')`,
  for single string/table args. Run `stylua .` before committing.
- Leader is `<space>`; both `mapleader` and `maplocalleader`.
- Keymaps use the local `map`/`opts` helpers in `init.lua`.
- Netrw is disabled (`vim.g.loaded_netrw = 1`); neo-tree is the file explorer.
- Transparency is enforced by `set_transparent()` plus a `ColorScheme` autocmd —
  new highlight groups that need a transparent bg go in that function, not scattered.

## Commits

`type(scope): summary` on the first line, then a blank line, then the details:

```
chore(ui-update): statusline shades reworked for the Dark+ theme

- MiniStatusline groups moved off magenta onto greys
- StatusLine/StatusLineNC forced transparent for the background image
```

- Types in use: `chore`, `fix`, `feat`. Scope is the area touched (`ui-update`, `keymaps`,
  `treesitter`, `lsp`, `neo-tree`) — omit it only when the change is genuinely repo-wide.
- Summary line: imperative-ish, lowercase after the colon, no trailing period.
- Body is optional for one-line changes; use it whenever the "why" isn't obvious from the diff.
- No `Co-Authored-By:` trailer — disabled via `includeCoAuthoredBy: false` in
  `.claude/settings.json`. Do not add it back by hand.

## Verifying a change

```sh
nvim --headless "+Lazy! sync" +qa     # plugin specs resolve
nvim --headless "+checkhealth" +qa    # broader sanity check
stylua --check .
```
A clean `nvim --headless +qa` exit (no error output) is the minimum bar before committing.

## Gotchas

- `lazy-lock.json` is in `.gitignore` — plugin versions are not pinned in git. Do not
  "fix" this by committing it unless asked.
- Upstream kickstart is the ancestor; large chunks are inherited. Don't refactor upstream
  files wholesale, keep diffs against upstream small and local.
- The stylua GitHub workflow is gated on `github.repository == 'nvim-lua/kickstart.nvim'`,
  so CI does not run on this fork. Format locally.
