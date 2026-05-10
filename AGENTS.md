# NixOS Configuration

## Architecture

```
flake.nix                # Entry point, defines system + home-manager configs
core/                    # Shared NixOS system config (boot, locales, services)
packages/                # System-level packages, LSPs, formatters, programs
home/                    # Home-manager config (user dotfiles, shell, apps)
  dotfiles/              # mkSymlinks helper + raw dotfile sources
hosts/                   # Per-machine overrides (hardware, extra pkgs/home)
overlays/                # pkgs.stable overlay + 3rd-party overlays
```

## Hosts

- **thinkpad-nixos**: Primary dev machine, uses `./core` + `./packages`
- **framework13-df**: Framework laptop, adds `./hosts/framework13-df/packages` + `./hosts/framework13-df/home`

## Commands

| Task                 | Command                 |
| -------------------- | ----------------------- |
| Rebuild system       | `nh os switch`          |
| Rebuild home-manager | `nh home switch`        |
| Update               | `nh os switch --update` |
| Garbage collect      | `nh clean all`          |

The flake lives at `~/.config/nixos`

Home-manager target format: `${username}@${hostname}` (e.g. `melker@thinkpad-nixos`).

## Key conventions

- **`nixpkgs-unstable`** is default; **`nixpkgs-stable` (25.05)** available as `pkgs.stable`
- **System uses `nh`** (nix helper) instead of raw `nixos-rebuild` / `home-manager`
- **Dotfiles** are symlinked via `mkSymlinks` out-of-store to allow live editing without rebuild

## Notable services

- Desktop: DankMaterialShell, Nautilus file manager, Brave browser
