<div align="center">

```
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

*A Wayland-first, keyboard-driven setup forged in the embers of Kanagawa Dragon*

---

![Arch Linux](https://img.shields.io/badge/Arch_Linux-1793D1?style=for-the-badge&logo=arch-linux&logoColor=white)
![Niri](https://img.shields.io/badge/WM-Niri-C8C093?style=for-the-badge&logoColor=black)
![Wayland](https://img.shields.io/badge/Wayland-FFBC42?style=for-the-badge&logo=wayland&logoColor=black)
![Neovim](https://img.shields.io/badge/Editor-Neovim-57A464?style=for-the-badge&logo=neovim&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-C34043?style=for-the-badge)

</div>

---

## 🐉 Overview

A carefully crafted dotfiles collection built around **[Niri](https://github.com/YaLTeR/niri)** — a scrollable, tiling Wayland compositor — wrapped in the warm, dark aesthetic of the **Kanagawa Dragon** colorscheme. Every tool in the stack is configured to work as a cohesive, keyboard-first environment for development and daily use.

The setup favors **precision over bloat**: minimal RAM overhead, fast startup times, and a consistent visual language across every application — from the terminal to the lock screen.

---

## 🗂️ Structure

```
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

---

## 🎨 Colorscheme — Kanagawa Dragon

> *"The mountains are distant, the fog is thick, the dragon stirs."*

The entire setup is themed around **[Kanagawa Dragon](https://github.com/rebelot/kanagawa.nvim)** — a dark, earthy palette inspired by the colors of Katsushika Hokusai's paintings.

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

---

## 🧩 The Stack

### 🪟 Niri — Window Manager
A **scrollable, tiling Wayland compositor** where windows are arranged in an infinite horizontal strip. No overlapping, no chaos — just clean, predictable tiling with buttery-smooth animations.

- Gesture-based workspace navigation
- Per-window rules for floating & sizing
- Deep integration with the Wayland ecosystem

---

### ✏️ Neovim — Editor
A full Lua-configured Neovim setup built for speed and ergonomics. The config is modular and plugin-managed for fast startup.

**Highlights:**
- LSP-first workflow with autocompletion, diagnostics, and formatting
- Treesitter for accurate syntax highlighting
- Telescope for fuzzy finding across files, buffers, and git history
- Full Kanagawa Dragon theming

---

### 📊 Waybar — Status Bar
A pixel-perfect status bar styled with custom CSS to match the Kanagawa Dragon palette.

**Modules:**
- Niri workspaces integration
- CPU, RAM, temperature monitoring
- Network status
- PipeWire audio control
- Date & time with calendar popup

---

### 🔒 Hyprlock — Lock Screen
A GPU-accelerated lock screen with custom **GLSL shaders** — the heaviest and most visually distinctive part of the setup. The shaders produce a dynamic background that fits the Dragon aesthetic perfectly.

> GLSL accounts for **61.5%** of the repository — because the lock screen deserves to be art.

---

### 🚀 Rofi — Application Launcher
A minimal, keyboard-driven launcher styled to blend seamlessly with the rest of the desktop. Fast, distraction-free, and themed consistently with Kanagawa Dragon colors.

---

### 👻 Ghostty — Terminal
[Ghostty](https://ghostty.org) is a modern, GPU-accelerated terminal emulator with native performance and a clean configuration format. Configured with:
- Kanagawa Dragon colors
- Optimized font rendering
- Minimal chrome — the focus is on your work

---

### 🔔 Mako — Notifications
A lightweight Wayland notification daemon. Styled to be unobtrusive: notifications appear, deliver their message, and get out of the way.

---

### 📁 Yazi — File Manager
A terminal file manager written in Rust, built for speed. Configured with:
- Preview support (images, text, archives)
- Custom keybindings
- Kanagawa Dragon theme

---

### 📸 Fastfetch — System Info
A fast, highly customizable system info tool. Because `neofetch` is tradition, but speed matters.

---

### 🛠️ `.local/bin` — Custom Scripts
A collection of shell scripts that automate common tasks and glue the desktop environment together. Kept minimal and POSIX-compliant where possible.

---

## 🚀 Installation

> **⚠️ Warning:** These dotfiles are personal and opinionated. Review every file before applying. No install script is provided intentionally — understanding your config is part of owning it.

### Prerequisites

Make sure the following packages are installed on your Arch system:

```bash
# Core
sudo pacman -S niri waybar hyprlock rofi-wayland mako ghostty yazi fastfetch neovim

# Optional but recommended
sudo pacman -S xdg-desktop-portal-gnome playerctl brightnessctl pipewire wireplumber
```

### Deploying

Clone the repo and stow (or symlink) the configs:

```bash
git clone https://github.com/Chrustho/Dotfiles.git ~/Dotfiles
cd ~/Dotfiles

# Option A — using GNU Stow (recommended)
stow --target=$HOME .

# Option B — manual copy
cp -r .config/* ~/.config/
cp -r .local/bin/* ~/.local/bin/
chmod +x ~/.local/bin/*
```

---

## ⌨️ Key Philosophy

> **"A tool should disappear in your hands."**

Every configuration decision here follows three rules:

1. **Keyboard-first** — mouse is optional, never required
2. **Consistent** — same colors, same fonts, same feel everywhere
3. **Fast** — if it's slow, it's wrong

---

## 📄 License

MIT — take what you need, build something yours.

---

<div align="center">

*Made with 🐉 and too many late nights on Arch*

</div>
