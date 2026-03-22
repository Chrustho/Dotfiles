<div align="center">

```text
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

*Personal Wayland dotfiles based on Niri and the Kanagawa Dragon colorscheme.*

---

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Niri](https://img.shields.io/badge/WM-Niri-C8C093?style=for-the-badge&logoColor=black)
![Wayland](https://img.shields.io/badge/Wayland-FFBC42?style=for-the-badge&logo=wayland&logoColor=black)
![Neovim](https://img.shields.io/badge/Editor-Neovim-57A464?style=for-the-badge&logo=neovim&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-C34043?style=for-the-badge)

</div>

---

## Overview

This repository contains the configuration files for my daily driver setup. It is a keyboard-centric Wayland environment built around the **Niri** compositor. The entire system is unified under the **Kanagawa Dragon** color palette for visual consistency across all applications. 

## Structure

```text
~
├── .config/
│   ├── niri/           # Compositor config (KDL)
│   ├── nvim/           # Neovim (Lua)
│   ├── waybar/         # Status bar (CSS + JSON)
│   ├── hyprlock/       # Lock screen (GLSL shaders + config)
│   ├── rofi/           # App launcher (Rasi)
│   ├── ghostty/        # Terminal emulator
│   ├── mako/           # Notification daemon
│   ├── fastfetch/      # System info display
│   └── yazi/           # Terminal file manager
│
└── .local/
    └── bin/            # Custom shell scripts
```

## Colorscheme

The system uses the **[Kanagawa Dragon](https://github.com/rebelot/kanagawa.nvim)** palette.

| Role        | Color     | Preview |
|-------------|-----------|---------|
| Background  | `#181616` | ![#181616](https://placehold.co/14x14/181616/181616.png) |
| Surface     | `#1D1C19` | ![#1D1C19](https://placehold.co/14x14/1D1C19/1D1C19.png) |
| Foreground  | `#C5C9C5` | ![#C5C9C5](https://placehold.co/14x14/C5C9C5/C5C9C5.png) |
| Red         | `#C34043` | ![#C34043](https://placehold.co/14x14/C34043/C34043.png) |
| Green       | `#76946A` | ![#76946A](https://placehold.co/14x14/76946A/76946A.png) |
| Yellow      | `#C0A36E` | ![#C0A36E](https://placehold.co/14x14/C0A36E/C0A36E.png) |
| Teal        | `#6A9589` | ![#6A9589](https://placehold.co/14x14/6A9589/6A9589.png) |
| Violet      | `#957FB8` | ![#957FB8](https://placehold.co/14x14/957FB8/957FB8.png) |

## Programs & Tools

Here is a breakdown of the core components configured in this repository and what they do:

* **[Niri](https://github.com/YaLTeR/niri):** The core window manager / Wayland compositor. Instead of standard grids, it tiles windows dynamically in an infinite horizontal strip that you can scroll through. It handles workspaces, window placement, and keyboard shortcuts.
* **Neovim:** A terminal-based text editor. It is configured via Lua to act as a full IDE, utilizing LSP for code completion and diagnostics, Treesitter for syntax highlighting, and Telescope for fuzzy finding files.
* **Waybar:** The system status bar. It displays real-time information such as active Niri workspaces, CPU/RAM usage, temperatures, network status, and a system tray.
* **Hyprlock:** A Wayland screen locker. It locks the session when the system is idle or sleeping. This config includes custom GLSL shaders to render a dynamic background while locked.
* **Rofi (rofi-wayland):** An application launcher. Triggered via keyboard shortcut, it provides a menu to search for and launch installed programs or execute commands.
* **Ghostty:** A GPU-accelerated terminal emulator. It provides the command-line interface where all shell commands, Neovim, and Yazi are run.
* **Mako:** A lightweight notification daemon for Wayland. It catches desktop notifications sent by applications and displays them as popups on the screen.
* **Yazi:** A terminal-based file manager written in Rust. Used for fast file system navigation, file manipulation, and features built-in image and text previews.
* **Fastfetch:** A command-line system information tool. It fetches and displays OS, hardware, and uptime details alongside an ASCII logo in the terminal.
* **Custom Scripts (`.local/bin`):** Various POSIX-compliant shell scripts that handle repetitive tasks, volume/brightness control hooks, and system automation.

## Installation

**Note:** Dotfiles are inherently personal. It is highly recommended to read through the configuration files before applying them to your system to understand the keybindings and behaviors.

### Dependencies (Arch Linux)

```bash
# Core packages
sudo pacman -S niri waybar hyprlock rofi-wayland mako ghostty yazi fastfetch neovim

# Utilities
sudo pacman -S xdg-desktop-portal-gnome playerctl brightnessctl pipewire wireplumber
```

### Deployment

Clone the repository and deploy the files. GNU Stow is recommended for managing symlinks.

```bash
git clone [https://github.com/Chrustho/Dotfiles.git](https://github.com/Chrustho/Dotfiles.git) ~/Dotfiles
cd ~/Dotfiles

# Using GNU Stow (Recommended)
stow --target=$HOME .

# Manual Copy Alternative
cp -r .config/* ~/.config/
cp -r .local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*
```

## License
MIT
