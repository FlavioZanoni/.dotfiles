# 🐧.dotfiles 

## my Arch Linux .dotfiles

### Included Configurations

- **Zsh**: Custom shell configuration and settings.
- **Neovim**: My Neovim setup, including plugins and keybindings.
- **Git**: Configuration for Git.
- **Hypr**: Hyperland configuration and keybindings.

## Setup

To get started with these dotfiles on your own machine, follow these steps:

### Prerequisites

- **GNU Stow**: A symlink farm manager. Install it using your package manager.
- **Git**: For version control and managing dotfiles.

### Installation

1. **Clone the Repository**

   ```bash
   git clone https://github.com/FlavioZanoni/.dotfiles.git ~/.dotfiles
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
   ```

   This will symlink the configuration files to their respective locations in your home directory.

