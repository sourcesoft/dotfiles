# Dotfiles

![Desktop screenshot](https://github.com/user-attachments/assets/e1bf9be0-8d6d-4aa4-bb3b-6463be82a398)

## Installation

These dotfiles are deployed with
[dotter](https://github.com/SuperCuber/dotter).

### Required Tools

Install the baseline tools first:

- [dotter](https://github.com/SuperCuber/dotter)
- [Ghostty](https://ghostty.org/)
- [Zellij](https://github.com/zellij-org/zellij)
- `zsh`
- [Starship](https://starship.rs/)
- Neovim 0.12 or newer
- Git
- `make`
- `unzip`
- Node.js and `npm`
- Go
- `ripgrep`
- `fd`
- `bat`
- `exa`
- `delta`
- `lf`
- `lazygit`
- GitHub CLI, `gh`

On macOS with Homebrew:

```sh
xcode-select --install
brew install dotter zellij starship neovim git unzip node go ripgrep fd bat \
  exa git-delta lazygit gh
brew install --cask ghostty
```

Install `lf` with Go:

```sh
go install github.com/gokcehan/lf@latest
```

Install a Nerd Font so Neovim icons render correctly. These configs reference
`Knack` in Alacritty and `Dank Mono` in Zed; install those if you want the
checked-in app configs to match exactly. Otherwise, install any Nerd Font and
adjust the relevant app font setting.

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

4. Start Neovim once to let `vim.pack` install plugins.

5. Install the configured Mason tools:

   ```sh
   nvim --headless '+MasonToolsInstallSync' +qa
   ```

The Neovim config manages these tools through Mason:

- `gopls`
- `lua-language-server`
- `gofumpt`
- `goimports`
- `stylua`
- `sql-formatter`
- `markdownlint`

### Verify

Run the custom health check:

```sh
nvim --headless '+checkhealth dotfiles' +qa
```

You can also open Neovim and run `:checkhealth dotfiles`.

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
