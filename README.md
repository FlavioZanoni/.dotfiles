# 🐧.dotfiles 

## my Arch Linux .dotfiles

### Included Configurations

- **Zsh**: Custom shell configuration and settings.
- **Neovim**: My Neovim setup, including plugins and keybindings.
- **Git**: Configuration for Git.
- **Hypr**: Hyprland configuration and keybindings.
- **Awesome**: Awesome wm config and binds
- **Fish**: Custom fish shell
- **Ghostty**: Ghostty terminal config

## Setup

To get started with these dotfiles on your own machine, follow these steps:

### Prerequisites

- **GNU Stow**: A symlink farm manager. Install it using your package manager.
- **Git**: For version control and managing dotfiles.

### Installation

1. **Clone the Repository**

   ```bash
   git clone git@github.com:FlavioZanoni/.dotfiles.git ~/.dotfiles
   ```

2. **Navigate to the Dotfiles Directory**

   ```bash
   cd ~/.dotfiles
   ```

3. **Stow Configuration**

   Use GNU Stow to create symlinks for the configurations you want to apply:

   ```bash
   stow zsh
   stow nvim
   stow git
   stow hypr
   etc...
   ```

   This will symlink the configuration files to their respective locations in your home directory.


## To create new symlinks

1. **Create the structure for the config inside ~/.dotfiles/ and copy what you want to save (including dir path)**

   So if the folder lives at ~/.config/ the folder would be: ./{config_name}/.config/{folder_name}/{config_file}

2. **Run the following command**

```cmd
   stow -t ~ $config_name
```
