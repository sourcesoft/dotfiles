# Dotfiles

![Desktop screenshot](https://github.com/user-attachments/assets/e1bf9be0-8d6d-4aa4-bb3b-6463be82a398)

## Installation

These dotfiles are deployed with
[dotter](https://github.com/SuperCuber/dotter).

### Required Tools

Install the baseline tools first:

- [dotter](https://github.com/SuperCuber/dotter)
- [Ghostty](https://ghostty.org/)
- [AeroSpace](https://github.com/nikitabobko/AeroSpace)
- [SketchyBar](https://github.com/FelixKratz/SketchyBar)
- [Zellij](https://github.com/zellij-org/zellij)
- `zsh`
- [Starship](https://starship.rs/)
- [Atuin](https://atuin.sh/)
- Neovim 0.12 or newer
- Git
- `make`
- A C compiler
- `curl`
- `tar`
- `unzip`
- Tree-sitter CLI 0.26.1 or newer, installed through your system package
  manager rather than `npm`
- Node.js and `npm`
- Go
- `pipx`
- `ripgrep`
- `fd`
- `bat`
- `eza`
- `delta`
- `lf`
- `lazygit`
- [sqlit](https://github.com/Maxteabag/sqlit)
- GitHub CLI, `gh`

On macOS with Homebrew:

```sh
xcode-select --install
brew install dotter zellij starship neovim git unzip tree-sitter node go \
  ripgrep fd bat eza git-delta lazygit gh pipx atuin
brew install --cask ghostty
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install sketchybar
brew install --cask font-symbols-only-nerd-font
```

Install sqlit for the Neovim `<leader>S` database UI:

```sh
pipx install sqlit-tui
pipx ensurepath
```

If sqlit needs an extra database driver, install it into the pipx app. For
example, PostgreSQL support uses:

```sh
pipx inject sqlit-tui psycopg2-binary
```

Install `lf` with Go:

```sh
go install github.com/gokcehan/lf@latest
```

Install a Nerd Font so Neovim icons render correctly. These configs reference
`Knack` in Alacritty and `Dank Mono` in Zed; install those if you want the
checked-in app configs to match exactly. Otherwise, install any Nerd Font and
adjust the relevant app font setting. The SketchyBar config specifically uses
`Symbols Nerd Font`, provided by the `font-symbols-only-nerd-font` cask above.

For zsh completions and suggestions, install
[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions).

### Optional Tools

- Rust/Cargo lets `blink.cmp` build its Rust fuzzy matcher from source.
- Authenticate `gh` with `gh auth login` if you want the Neovim GitHub PR,
  issue, action, and diff pickers to work.

### Setup

1. Clone the repo:

   ```sh
   git clone git@github.com:sourcesoft/dotfiles.git
   cd dotfiles
   ```

2. Create a local dotter config if you need template variables:

   ```sh
   cp .dotter/local.toml.example .dotter/local.toml
   ```

3. Apply the configurations:

   ```sh
   dotter deploy
   ```

   Atuin stores new shell history in a local SQLite database. To import existing
   zsh history without enabling sync, run:

   ```sh
   atuin import zsh
   ```

   The zsh config binds Atuin to `Ctrl-R` and up-arrow history search.

4. Start AeroSpace and SketchyBar.

   The AeroSpace config starts SketchyBar with the dotter-managed config at
   `~/.config/sketchybar/sketchybarrc`. Do not copy SketchyBar's example
   config over it after `dotter deploy`.

   ```sh
   open -a AeroSpace
   aerospace reload-config
   ```

   On first launch, grant AeroSpace the macOS permissions it asks for in
   System Settings, especially Accessibility. If SketchyBar was already running
   from a previous Homebrew service setup, stop that service and restart
   AeroSpace so the checked-in config is the one that starts it:

   ```sh
   brew services stop felixkratz/formulae/sketchybar 2>/dev/null || true
   pkill sketchybar 2>/dev/null || true
   open -a AeroSpace
   ```

   To reload only the bar after editing its config:

   ```sh
   sketchybar --reload ~/.config/sketchybar/sketchybarrc
   ```

5. Start Neovim once to let `vim.pack` install plugins.

6. Install the configured Mason tools:

   ```sh
   nvim --headless '+MasonToolsInstallSync' +qa
   ```

The Neovim config manages these tools through Mason:

- `autotools-language-server`
- `clangd`
- `css-lsp`
- `doctoc`
- `docker-language-server`
- `gopls`
- `helm-ls`
- `html-lsp`
- `json-lsp`
- `lua-language-server`
- `markdown-oxide`
- `rust-analyzer`
- `sqls`
- `terraform-ls`
- `tflint`
- `typescript-language-server`
- `yaml-language-server`
- `gofumpt`
- `goimports`
- `stylua`
- `sql-formatter`

Markdown-Oxide also reads the dotter-managed global config at
`~/.config/moxide/settings.toml`. For one project only, add `.moxide.toml` at
that project root.

### Markdown Files

Open `.md` files in Neovim to use Markdown-Oxide. It provides Markdown link,
wikilink, heading, tag, reference, rename, diagnostics, hover, inlay hint, and
code action support through normal LSP mappings:

```txt
gd           go to linked note, heading, or block
grr          show references/backlinks
<leader>ca   run code actions, such as creating an unresolved linked file
<leader>R    rename the current note, heading, or symbol
<leader>k    show hover
<leader>lh   toggle inlay hints
<leader>ll   run code lens actions in Markdown files
:Daily       open today's daily note
:Daily next  open the next daily note
:Daily -3    open the daily note from three days ago
:TOC         add or update a DocToc table of contents
```

Use `:TOC` in Neovim to add or update a GitHub-compatible table of contents in
the current Markdown buffer. It runs Mason-managed `doctoc` with these defaults:

```txt
--github --toc-location before --title '**Table of Contents**'
```

In Neovim, `:TOC` expands to `:Toc`, which runs `doctoc` on the current
`.md`, `.markdown`, or `.mdx` buffer. Extra arguments are passed through before
the current file, so `:TOC --maxlevel 3` works.

Raw `doctoc` also works from the shell:

```sh
doctoc --github --toc-location before --title '**Table of Contents**' README.md
doctoc --github --toc-location before --title '**Table of Contents**' docs/
doctoc --github --toc-location before --title '**Table of Contents**' --update-only README.md
doctoc --github --toc-location before --title '**Table of Contents**' --dryrun README.md
```

`:Daily` asks Markdown-Oxide to open a daily note and create the file if it does
not exist. With the default config, daily notes are named `YYYY-MM-DD.md` in the
workspace root. Set `daily_notes_folder = "notes/daily"` in `.moxide.toml` or
`~/.config/moxide/settings.toml` to put them somewhere else.

```vim
:Daily
:Daily tomorrow
:Daily next monday
:Daily prev
:Daily +7
:Daily -3
```

### Verify

Run the custom health check:

```sh
nvim --headless '+checkhealth dotfiles' +qa
```

You can also open Neovim and run `:checkhealth dotfiles`.

### Local Secrets And Machine Overrides

Do not put API keys, tokens, or machine-specific paths in tracked dotfiles or in
`.dotter/local.toml`. Shell startup loads local secrets from:

```sh
~/.config/shell/env.private
```

Create it with regular shell exports:

```sh
mkdir -p ~/.config/shell
chmod 700 ~/.config/shell
touch ~/.config/shell/env.private
chmod 600 ~/.config/shell/env.private
```

Example format:

```sh
export OPENAI_API_KEY="..."
export GOOGLE_AI_API_KEY="..."
```

For machine-specific shell setup, use local-only hooks:

```sh
~/.bashrc.local
~/.zshrc.local
```

Use those files for work-only aliases, per-machine `PATH` entries, company
settings such as `GOPRIVATE`, and tools installed in nonstandard locations.

## Mappings and Environment

It's much easier to use right CMD or Alt instead of reaching out to escape.
I also use Caps Lock for Control, since it's closer and easier to hit.

- Escape -> Right CMD or Right Alt
- Control -> Caps Lock

Tools to set up the key bindings:

- OSX: Use Karabiner to map

  [Karabiner-Elements](https://github.com/tekezo/Karabiner-Elements)

- Ubuntu: Install [xcape](https://github.com/alols/xcape)

  - Use the following command: `xcape -e 'Alt_R=Escape;ISO_Level3_Shift=Escape'`
