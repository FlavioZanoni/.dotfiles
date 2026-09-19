# Minimal Hyprland

Fresh standalone configuration for Hyprland **0.55+ (Lua)**, inspired by the
Awesome keybindings in this repository. Does not source or start anything from
the legacy `hypr/` package.

## Install

Back up any existing `~/.config/hypr/hyprland.lua` and `~/.config/mako/config`
before installing. From the dotfiles root:

```sh
stow -t "$HOME" hypr
hyprctl reload
makoctl reload
```

Mako starts at the next Hyprland login
if it is not already running; run `mako` to start it in an existing session.

Required: Hyprland, Mako, Waybar, Fish, Kitty, Rofi with Wayland support.
Rofi extras: `rofi-calc` (calculator), `cliphist` (clipboard history).
Screenshots: `grim`, `slurp`, `wl-clipboard`. Install missing tools with:

```sh
sudo pacman -S --needed grim slurp wl-clipboard cliphist rofi-calc
```
Optional shortcut dependencies: `wireplumber` (`wpctl`), `brightnessctl`,
`hyprlock`, `grim`, `slurp`, and `wl-clipboard`. Configure Hyprlock before using
the lock shortcut. The top bar starts on login; animations, blur and shadows are disabled.

On Arch, install the bar and set the login shell with:

```sh
sudo pacman -S --needed waybar fish
chsh -s /usr/bin/fish
sh ~/.config/hypr/scripts/start-bar.sh
```

The login shell changes at the next login. New Kitty windows use Fish immediately.
Kitty is the default terminal (`TERMINAL=kitty`, `Super+Return`, xdg-terminal-exec).
The existing `fish/` package supplies the Fish configuration and Tide prompt;
`fish/.config/fish/conf.d/nvim-dark.fish` matches its colours to Nvim Dark.
Kitty uses the same Nvim Dark palette as the repository's Ghostty configuration.

## Top bar and launcher

Waybar runs on both displays, with monitor-local numbered workspaces, focused
window title, centred date/clock, CPU, NVIDIA GPU usage, RAM, live network
download/upload rates, volume and a system tray. GPU utilization refreshes every
three seconds using `nvidia-smi`; its tooltip shows VRAM usage and temperature.
Network rates refresh every second and show the interface selected by Waybar
(ETH or WiFi), not the sum of both connections.
All configured workspaces remain visible even when empty. Click a workspace to
switch, click the launcher to open Rofi, click volume to mute, or scroll volume
to adjust it. Click the clock to toggle the detailed date; hover for a calendar.
`Super+B` hides/shows the bar.

`Super+R` opens Rofi with a matching Nvim Dark theme and `Ctrl+j/k` selection.
The existing standalone Rofi configuration remains available to other launchers.

## Displays

- LG ULTRAWIDE: 3440×1440 at ~160 Hz, landscape, origin `0x0`, workspaces 1–5.
- AOC 2269WM: 1920×1080 at 60 Hz, rotated to 1080×1920, left at `-1080x0`,
  workspaces 6–10 (10 is the `0` key).
- Displays are matched by description, so changing ports does not break the rules.
- The LG is the startup focus/default cursor display. Wayland has no universal
  primary-monitor flag; workspace assignment and startup focus implement that role.
- The screens are top-aligned. Change AOC `transform = 1` to `3` if it is rotated
  in the opposite physical direction. Other displays use their preferred mode.

## Keyboard

`Super` is the Windows key. Directional keys follow Vim: `h/j/k/l`.

| Shortcut | Action |
| --- | --- |
| Super + h/j/k/l | Focus left/down/up/right |
| Super + Shift + h/j/k/l | Rearrange tiles; move floating windows by 40 px |
| Super + Alt + h/l | Shrink/grow width by 40 px |
| Super + Alt + k/j | Shrink/grow height by 40 px |
| Super + Ctrl + Alt + h/j/k/l | Alias for tiled resize |
| Super + Ctrl + Space | Toggle floating / return to tiling |
| Super + Space | Toggle the dwindle split direction |
| Super + f / m | Toggle fullscreen / maximized |
| Super + q | Close window |
| Super + Return / r | Terminal / app launcher |
| Super + c | Rofi calculator (copies result to clipboard) |
| Ctrl + Shift + p | Clipboard history (cliphist via Rofi, Enter copies) |
| Super + Shift + c | Centre a floating window |
| Super + b | Hide/show top bar |
| Super + Tab | Previous focused window |
| Super + Left/Right | Previous/next workspace on this monitor |
| Super + Escape | Previous workspace |
| Super + 1–0 | Select workspace |
| Super + Shift + 1–0 | Move window to workspace |
| Super + Ctrl + h/l | Focus left/right monitor |
| Super + Ctrl + j/k | Focus next/previous monitor |
| Super + o | Move window to next monitor and follow |
| Super + t | Pin a floating window across workspaces |
| Super + left/right mouse drag | Move/resize |
| Ctrl + Space | Dismiss all notifications |
| Super + n | Restore last notification |
| Super + g | Lock (requires Hyprlock) |
| Super + Shift + s | Region screenshot to clipboard |
| Super + Ctrl + r | Reload configuration |

### Tiled resizing

`Super+Alt+h/l` shrinks/grows the focused tile's width; `Super+Alt+k/j`
shrinks/grows its height. Neighbouring tiles gain or give up space automatically.
Resizing never changes a window's floating state. Dwindle smart resizing is
enabled; available boundaries depend on the split tree. A window spanning the
entire workspace height or width has no neighbour to exchange space with on that
axis. `Super+Space` changes the split direction.

Use `Super+Ctrl+Space` to return an already-floating window to tiling.
Kitty's close-confirmation prompt is disabled by this package's `kitty.conf`.

Notifications are compact, square, dark, icon-free, with at most two visible.
Normal notifications expire after five seconds; critical ones remain until dismissed.

## Validation

```sh
Hyprland --verify-config -c "$HOME/.config/hypr/hyprland.lua"
hyprctl configerrors
```
