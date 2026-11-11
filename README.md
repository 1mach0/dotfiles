# dotfiles

My macOS setup: zsh, Neovim, Ghostty, Starship, fastfetch, gh, herdr.

## Layout

<table>
  <thead>
    <tr>
      <th width="320">Path</th>
      <th>What</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><code>.zshrc</code></td>
      <td>zsh: zinit, Starship, zoxide, fzf, eza aliases</td>
    </tr>
    <tr>
      <td><code>.config/starship.toml</code></td>
      <td>Starship prompt (base16-black-metal palette)</td>
    </tr>
    <tr>
      <td><code>.config/nvim/</code></td>
      <td>Neovim: single-file config, colours taken from Ghostty's base16-black-metal</td>
    </tr>
    <tr>
      <td><code>.config/ghostty/</code></td>
      <td>Ghostty config + <code>base16-black-metal</code> theme</td>
    </tr>
    <tr>
      <td><code>.config/fastfetch/</code></td>
      <td>fastfetch modules + logo</td>
    </tr>
    <tr>
      <td><code>.config/gh/config.yml</code></td>
      <td>GitHub CLI settings (auth in <code>hosts.yml</code> is not tracked)</td>
    </tr>
    <tr>
      <td><code>.config/herdr/config.toml</code></td>
      <td>herdr config</td>
    </tr>
    <tr>
      <td><code>.config/herdr-app/</code></td>
      <td>herdr app settings, keybindings, layouts</td>
    </tr>
    <tr>
      <td><code>linux/</code></td>
      <td>Old CachyOS setup (Hyprland, Waybar, Wofi, Alacritty, kickstart.nvim, p10k zshrc). Not installed on macOS.</td>
    </tr>
  </tbody>
</table>

## Install

```sh
git clone https://github.com/1mach0/dotfiles ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` symlinks every tracked macOS file into `$HOME` (existing files are moved to `*.pre-dotfiles`) and clones
[ghostty-cursor-shaders](https://github.com/sahaj-b/ghostty-cursor-shaders) into `~/.config/ghostty/shaders`.
It skips `linux/`, `README.md`, `install.sh`, and `.gitignore`. New configs are picked up automatically once they're committed.
Because they're symlinks, editing `~/.config/nvim/init.lua` edits the repo — just commit and push.
