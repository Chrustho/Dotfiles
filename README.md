```text
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

Dotfiles del mio ambiente Wayland su Arch Linux, basato sul compositor Niri e su un sistema di temi commutabili a caldo.

## Componenti

| Ambito | Programma | Formato |
|---|---|---|
| Compositor | Niri | KDL |
| Status bar | Waybar | CSS + JSONC |
| Launcher / menu | Rofi | Rasi |
| Notifiche | Mako | conf |
| Terminale | Ghostty, Alacritty | conf, TOML |
| Lock / idle | Hyprlock, Hypridle | conf |
| Sfondo animato | neowall | GLSL + vibe |
| OSD volume/luminosità | SwayOSD | CSS |
| System info | Fastfetch | JSONC |
| Editor | Neovim | Lua |
| Discord | Vencord (tema system24) | CSS |

## Sistema di temi

Ogni programma ha la sua cartella `themes/` con una variante per palette. Lo switch avviene riscrivendo il file attivo e ricaricando il programma, senza riavviare la sessione.

| Switcher | Cosa cambia | Scorciatoia |
|---|---|---|
| `niri-theme.sh` | Tema di sistema: Niri, sfondo, Mako e SwayOSD in un colpo. Imposta anche i gap della tiling per alcuni temi. | `Mod+Alt+T` |
| `rofi-theme.sh` | Palette di Rofi | `Mod+Alt+R` |
| `waybar-theme.sh` | Tema di Waybar | `Mod+Alt+B` |

Temi di sistema disponibili (Niri/Rofi/Mako, 18):

```text
original    cyberdeck   aero        ink
everforest  rosepine    oxocarbon   synthwave
deathstranding  dune    matrix      win95
bauhaus     concrete    editorial   mocha
poimandres  eldritch
```

Waybar ha 11 temi propri più le varianti `bridges/` e `gruvbox/`.

## Struttura

```text
~
├── .config/
│   ├── niri/         # Compositor (config + dms/ + themes/)
│   ├── waybar/       # Status bar (config, stile, themes/)
│   ├── rofi/         # Launcher e menu (power, rete, clipboard)
│   ├── mako/         # Notifiche
│   ├── ghostty/      # Terminale + shaders
│   ├── alacritty/    # Terminale alternativo
│   ├── hypr/         # hyprlock + hypridle
│   ├── neowall/      # Sfondo animato + shaders GLSL
│   ├── swayosd/      # OSD
│   ├── fastfetch/    # System info + sprites
│   ├── Vencord/      # Tema Discord
│   └── nvim/         # Neovim
└── .local/
    └── bin/          # Script: theme switcher, slideshow, powermenu, toggle sfondo
```

## Installazione

I dotfiles sono gestiti come repository git "bare", così i file restano nelle loro posizioni dentro `$HOME`.

```sh
git clone --bare git@github.com:Chrustho/Dotfiles.git "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
dotfiles config status.showUntrackedFiles no
```

Se `checkout` segnala dei file già esistenti, spostali altrove e ripeti il comando.

## Note

I file in `.config/niri/dms/` sono generati da DankMaterialShell e non vanno modificati a mano.
