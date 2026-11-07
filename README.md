# dotfiles

My macOS setup: zsh, Neovim, Ghostty, git, fastfetch.

## Layout

| Path | What |
|---|---|
| `.config/nvim/init.lua` | Neovim: single-file config, colours taken from Ghostty's base16-black-metal |
| `.config/ghostty/` | Ghostty config + `base16-black-metal` theme |
| `.config/fastfetch/config.jsonc` | fastfetch modules |
| `.gitconfig` | git identity, SSH commit signing |
| `linux/` | Old CachyOS setup (Hyprland, Waybar, Wofi, Alacritty, kickstart.nvim, p10k zshrc). Not installed on macOS. |

## Install

```sh
git clone https://github.com/1mach0/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` symlinks each file into `$HOME` (existing files are moved to `*.pre-dotfiles`) and clones
[ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders) into `~/.config/ghostty/shaders`.
Because they're symlinks, editing `~/.config/nvim/init.lua` edits the repo — just commit and push.
