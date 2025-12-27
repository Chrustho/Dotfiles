# 🎨 Dotfiles

> Gruvbox-themed dotfiles for a Fedora + Niri setup

![Fedora](https://img.shields.io/badge/Fedora-51A2DA?style=flat&logo=fedora&logoColor=white)
![Niri](https://img.shields.io/badge/Niri-Wayland-blue?style=flat)
![Neovim](https://img.shields.io/badge/Neovim-LazyVim-green?style=flat&logo=neovim)
![License](https://img.shields.io/badge/License-Apache%202.0-orange?style=flat)

---

## 📦 What's Included

| Application | Description | Config Path |
|-------------|-------------|-------------|
| **[Niri](https://github.com/YalterS/niri)** | Scrollable-tiling Wayland compositor | `Niri/.config/niri/` |
| **[Neovim](https://neovim.io/)** | LazyVim-based configuration | `nvim/.config/nvim/` |
| **[Alacritty](https://alacritty.org/)** | GPU-accelerated terminal | `Alacritty/.config/alacritty/` |
| **[Zellij](https://zellij.dev/)** | Terminal multiplexer | `Zellij/.config/zellij/` |
| **[Fuzzel](https://codeberg.org/dnkl/fuzzel)** | Wayland application launcher | `Fuzzel/.config/fuzzel/` |
| **[Swaylock](https://github.com/swaywm/swaylock)** | Screen locker with blur effect | `Swaylock/.config/swaylock/` |
| **[Fastfetch](https://github.com/fastfetch-cli/fastfetch)** | System information tool | `Fastfetch/.config/fastfetch/` |
| **DankMaterialShell** | Desktop shell/bar | `DankMaterialShell/.config/DankMaterialShell/` |

---

## 🎯 Features

- **Unified Gruvbox Material** theme across all applications
- **Vim-style keybindings** (hjkl navigation) in Niri, Zellij, and Neovim
- **LazyVim** setup with extras for Rust, Python, Java, C/C++, SQL, and LaTeX
- **Focus-follows-mouse** with scrollable tiling in Niri
- **Italian keyboard layout** configured by default

---

## ⌨️ Key Bindings (Niri)

### Window Management

| Binding | Action |
|---------|--------|
| `Mod+H/J/K/L` | Focus left/down/up/right |
| `Mod+Ctrl+H/J/K/L` | Move window left/down/up/right |
| `Mod+Shift+H/J/K/L` | Focus monitor left/down/up/right |
| `Mod+Q` | Close window |
| `Mod+F` | Maximize column |
| `Mod+Shift+F` | Fullscreen window |
| `Mod+V` | Toggle floating |
| `Mod+C` | Center column |
| `Mod+R` | Cycle column width presets |

### Workspaces

| Binding | Action |
|---------|--------|
| `Mod+1-9` | Switch to workspace 1-9 |
| `Mod+Ctrl+1-9` | Move window to workspace 1-9 |
| `Mod+U/I` | Focus workspace down/up |
| `Mod+O` | Toggle overview |

### Applications

| Binding | Action |
|---------|--------|
| `Mod+T` | Open Alacritty terminal |
| `Mod+D` | Fuzzel launcher |
| `Mod+B` | Firefox |
| `Super+Escape` | Lock screen (swaylock) |
| `Print` | Screenshot |

---

## 🛠️ Dependencies

```bash
# Core
sudo dnf install niri alacritty zellij fuzzel swaylock fastfetch

# Neovim (latest)
sudo dnf install neovim

# Fonts
sudo dnf install jetbrains-mono-fonts

# Additional tools
sudo dnf install brightnessctl playerctl wpctl
```

---

## 📥 Installation

This repository uses [GNU Stow](https://www.gnu.org/software/stow/) for symlink management.

```bash
# Clone the repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles
cd ~/dotfiles

# Install stow
sudo dnf install stow

# Stow individual configs
stow nvim
stow Alacritty
stow Niri
stow Zellij
stow Fuzzel
stow Swaylock
stow Fastfetch

# Or stow everything
stow */
```

---

## 🖥️ Neovim Setup

Based on [LazyVim](https://www.lazyvim.org/) with the following extras enabled:

- `lang.clangd` — C/C++ support
- `lang.rust` — Rust with rustaceanvim
- `lang.python` — Python with venv-selector
- `lang.java` — Java with nvim-jdtls
- `lang.kotlin` — Kotlin support
- `lang.sql` — SQL with dadbod
- `lang.tex` — LaTeX with vimtex
- `lang.git` — Git integration
- `editor.telescope` — Fuzzy finder
- `util.project` — Project management

**Colorscheme:** `gruvbox-material` (hard background, italics enabled)

---

## 🎨 Color Palette

The entire setup uses **Gruvbox Material Hard Dark**:

| Color | Hex | Usage |
|-------|-----|-------|
| Background | `#1d2021` | Terminal, editor background |
| Foreground | `#d4be98` | Primary text |
| Orange | `#e78a4e` | Accent, primary |
| Green | `#89b482` | Secondary, success |
| Red | `#ea6962` | Error, urgent |
| Yellow | `#d8a657` | Warning |
| Blue | `#7daea3` | Info |

---

## 📁 Structure

```
dotfiles/
├── Alacritty/.config/alacritty/
│   ├── alacritty.toml
│   └── themes/
├── Niri/.config/niri/
│   ├── config.kdl
│   └── dms/                    # DankMaterialShell integration
├── nvim/.config/nvim/
│   ├── init.lua
│   └── lua/
│       ├── config/
│       └── plugins/
├── Zellij/.config/zellij/
│   └── config.kdl
├── Fuzzel/.config/fuzzel/
│   └── fuzzel.ini
├── Swaylock/.config/swaylock/
│   └── config
├── Fastfetch/.config/fastfetch/
│   └── config.jsonc
└── DankMaterialShell/.config/DankMaterialShell/
    ├── settings.json
    └── theme.json
```

---

## 📝 Notes

- **Display:** Configured for 1920x1080@120Hz with 1x scaling
- **Font:** JetBrainsMono Nerd Font throughout
- **Animations:** Niri animations slowed to 1.5x for smoother feel
- **Gaps:** 7px in Niri, 4px with DMS layout override
- **Corner radius:** 10-12px on windows

---

## 📄 License

[Apache 2.0](LICENSE)
