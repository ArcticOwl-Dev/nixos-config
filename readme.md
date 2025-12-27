# NixOS Configuration

## Structure

This repository follows a modular structure for organizing NixOS and Home Manager configurations:

```
nixos-config/
├── clients/              # Machine-specific configurations
│   ├── snowfire/        # Snowfire machine config
│   │   ├── configuration.nix      # NixOS system config
│   │   ├── hardware-configuration.nix
│   │   ├── home.nix               # Home Manager config
│   │   └── style.nix              # Styling/theming
│   └── stardust/        # Stardust machine config
│
├── nixos/               # NixOS configuration files
│   ├── configuration.nix          # Base NixOS config
│   ├── desktop/                   # Desktop environment configs
│   ├── sound/                     # Audio configuration
│   ├── i18n/                      # Internationalization
│   └── remote-touchpad/           # Service configuration files
│
├── modules/             # Reusable NixOS modules
│   └── remote-touchpad/           # Module definitions (options + logic)
│
├── pkgs/                # Custom package definitions
│   ├── default.nix                # Package exports
│   └── remote-touchpad/           # Package build definitions
│
├── home/                # Home Manager modules
│   ├── browser/                    # Browser configurations
│   ├── desktop/                    # Desktop environment configs
│   ├── cli/                        # CLI tool configurations
│   └── appLauncher/                # Application launcher configs
│
├── overlays/            # Nixpkgs overlays
│   └── default.nix                # Overlay definitions
│
├── assets/              # Static assets (wallpapers, etc.)
│
├── flake.nix            # Flake definition
└── flake.lock           # Flake lock file
```

### Directory Purposes

- **`clients/`** - Machine-specific configurations (system + home manager)
- **`nixos/`** - NixOS configuration files (values, not module definitions)
- **`modules/`** - Reusable NixOS modules (define options and system integration)
- **`pkgs/`** - Custom package definitions (how to build/fetch packages)
- **`home/`** - Home Manager configuration modules
- **`overlays/`** - Nixpkgs overlays for custom packages

See `pkgs/readme.md` and `modules/readme.md` for more details on those directories.

## How to Use

```bash
sudo nixos-rebuild switch --flake .#snowfire
```
