```text
██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
```

Configurazione del mio ambiente Wayland su Arch Linux. Il cuore è il compositor Niri, e sopra ci gira un sistema di temi che tocca quasi tutti i programmi della sessione con una scorciatoia sola.

## Componenti

| Ambito | Programma | Formato |
|---|---|---|
| Compositor | Niri | KDL |
| Status bar | Waybar | CSS + JSONC |
| Launcher e menu | Rofi | Rasi |
| Notifiche | Mako | conf |
| OSD volume/luminosità | SwayOSD | CSS |
| Terminali | Ghostty, Alacritty | conf, TOML |
| Lock e idle | Hyprlock, Hypridle | conf |
| Sfondo animato | neowall, awww | GLSL |
| System info | Fastfetch | JSONC |
| Editor | Neovim | Lua |
| Discord | Vencord | CSS |

Gli script che tengono insieme il tutto stanno in `~/.local/bin`: gli switcher dei temi, il selettore di sfondi, il power menu e la rotazione degli shader.

## Sistema di temi

Ogni programma ha una cartella `themes/` con un file per palette. Cambiare tema vuol dire riscrivere il file attivo con quello scelto e ricaricare il programma, senza mai riavviare la sessione. Niri e Rofi fanno il reload da soli; Mako, SwayOSD e Waybar vengono ricaricati dallo script.

Lo switcher di Niri è quello principale. Quando scegli un tema di sistema cambia in cascata Niri, lo sfondo, le notifiche di Mako e l'OSD di SwayOSD. Rofi, Waybar e Hyprlock hanno switcher separati, così puoi mescolare le combinazioni.

| Scorciatoia | Script | Cosa cambia |
|---|---|---|
| `Mod+Alt+T` | `niri-theme.sh` | Tema di sistema: Niri, sfondo, Mako, SwayOSD |
| `Mod+Alt+R` | `rofi-theme.sh` | Palette di Rofi |
| `Mod+Alt+F` | `rofi-layout.sh` | Forma della finestra di Rofi |
| `Mod+Alt+B` | `waybar-theme.sh` | Tema di Waybar |
| `Mod+Alt+L` | `waybar-layout.sh` | Layout della barra (posizione e forma) |
| `Mod+Alt+H` | `hyprlock-theme.sh` | Stile della schermata di lock |
| `Mod+Alt+G` | `wallpaper-picker.sh` | Sfondo, scelto a mano |

I 27 temi di sistema condivisi da Niri, Rofi, Mako e SwayOSD:

```text
original    cyberdeck   aero        ink
everforest  bio         rosepine    oxocarbon
synthwave   gruvmaterial deathstranding dune
matrix      win95       bauhaus     concrete
editorial   mocha       poimandres  eldritch
neochor     periwinkle  dechor      mellow
mystbloom   oh-lucy     petrichor
```

Gli ultimi sette (da `neochor` a `petrichor`) sono la famiglia "petrichor": palette piatte, bordi sottili, angoli vivi. Erano già in Niri e Rofi da un po', mentre Mako e SwayOSD si fermavano ai venti temi più vecchi. Ora anche loro coprono tutti e 27, quindi scegliendo uno di questi temi le notifiche e l'OSD si adeguano invece di restare indietro.

Waybar tiene una sua lista a parte. Oltre ai temi che coincidono con quelli di sistema porta alcune varianti sue: `gruvbox`, `chevron`, `glass`, `neon`, `catppuccin`, `nord`, `tokyonight`, `rosepine-power`. Il layout della barra è indipendente dal colore: `bottom`, `dock`, `floating`, `islands`, `split`, `vertical`.

## Struttura

```text
~
├── .config/
│   ├── niri/         # Compositor: config.kdl + themes/
│   ├── waybar/       # Barra: config, style.css, themes/, layout
│   ├── rofi/         # Launcher e menu (power, rete, clipboard)
│   ├── mako/         # Notifiche + themes/
│   ├── swayosd/      # OSD volume/luminosità + themes/
│   ├── ghostty/      # Terminale + shaders
│   ├── alacritty/    # Terminale alternativo
│   ├── hypr/         # hyprlock + hypridle
│   ├── neowall/      # Sfondo animato + shaders GLSL
│   ├── fastfetch/    # System info + sprites
│   ├── Vencord/      # Tema Discord
│   └── nvim/         # Neovim
└── .local/
    └── bin/          # Switcher, slideshow, power menu, toggle sfondo
```

## Installazione

Il repo è un bare repo con il work-tree sulla home, quindi i file vivono direttamente in `~/.config` senza una cartella di checkout separata.

```sh
git clone --bare git@github.com:Chrustho/Dotfiles.git "$HOME/.dotfiles"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles checkout
dotfiles config status.showUntrackedFiles no
```

Se `checkout` si lamenta di file già presenti, spostali altrove e ripeti il comando.

## Dipendenze principali

Pacchetti attesi nella sessione, avviati da `niri/config.kdl`:

- `niri`, `waybar`, `rofi`, `mako`, `swayosd`
- `xwayland-satellite` per le app X11
- `neowall` e `awww` (con `awww-daemon`) per lo sfondo
- `hypridle` e `hyprlock` per idle e lock
- `cliphist` con `wl-clipboard` per la cronologia degli appunti
- `blueman` per l'applet bluetooth
- i terminali `ghostty` e `alacritty`

I temi danno per scontato il font **IosevkaTerm Nerd Font**.

## Aggiungere un tema

Un tema è un file per programma con lo stesso nome nelle rispettive cartelle `themes/`:

- `niri/themes/<nome>.kdl`
- `rofi/themes/<nome>.rasi`
- `mako/themes/<nome>.conf`
- `swayosd/themes/<nome>.css`
- `waybar/themes/<nome>.css`, se vuoi che compaia anche nella barra

Le palette dei quattro file di sistema usano gli stessi colori, quindi conviene partire dal `.rasi` di Rofi (ha già bg, foreground, accento e i colori di stato) e riportarli negli altri. Alla fine aggiungi il nome alla lista dentro lo switcher corrispondente in `.local/bin/`, altrimenti non appare nel menu.
