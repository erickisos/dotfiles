# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal dotfiles repository using **literate programming** via Org-mode. The source of truth for all configurations lives in `docs/*.org` files, which tangle (generate) the actual config files in the repo root and `.doom.d/`.

## Architecture

The repository uses Org-mode's `#+begin_src ... :tangle <path>` blocks to generate config files. When editing configurations, the canonical place to make changes is the corresponding `.org` file in `docs/`, not the generated file directly.

| Source file | Generates |
|---|---|
| `docs/main.org` | `.env`, `.zshrc`, `.zsh_aliases` |
| `docs/doom.org` | `.doom.d/config.el`, `.doom.d/packages.el`, `.doom.d/functions.el` |
| `docs/git.org` | `.gitconfig` |
| `docs/nubank.org` | `.nubank_env`, `.nubank_rc`, `.nubank_aliases`, `.nubank_functions` |

## Tangling (generating config files from org sources)

To re-generate config files from an org source, open the file in Emacs and run:
```
M-x org-babel-tangle
```

Or from the command line:
```sh
emacs --batch -l org --eval "(org-babel-tangle-file \"docs/main.org\")"
```

## Doom Emacs

The `.doom.d/` directory contains Doom Emacs configuration:
- `config.org` — literate config (tangled to `config.el`); **edit this, not `config.el`**
- `init.el` — Doom module selection (edit directly; run `doom sync` after changes)
- `packages.el` — extra package declarations
- `functions.el` — custom elisp utilities (generated from `docs/doom.org`)

After modifying `init.el` or `packages.el`, run:
```sh
doom sync
```

## Shell environment

The shell stack loads in this order:
1. `.env` — environment variables and PATH setup (sourced by `.zshrc`)
2. `.zshrc` — oh-my-zsh config, sources `.zsh_aliases` and optionally `.nubank_*` files
3. `.zsh_aliases` — shared aliases across environments

Nubank-specific files (`.nubank_*`) are only sourced when `$NU_HOME` (`~/dev/nu`) exists.

## Key conventions

- **Literate-first**: changes to shell config and Doom config belong in `docs/*.org`, not in the generated files. Generated files diverge from their org source after each tangle.
- **GPG-signed commits**: the `.gitconfig` enforces `gpgsign = true`.
- **Git URLs rewrite**: all `https://github.com/` URLs are rewritten to `git@github.com:` via `.gitconfig`.
