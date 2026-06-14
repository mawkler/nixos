# NixOS Configuration

## Architecture

```
flake.nix                # Entry point, defines system + home-manager configs
features/                # Various features like SSH, GPU, CachyOS kernel, etc.
  core.nix               # Core features shared by all systems
packages/                # System-level packages, LSPs, formatters, programs
home/                    # Home-manager config (user dotfiles, shell, apps)
  dotfiles/              # mkSymlinks helper + raw dotfile sources
hosts/                   # Per-machine overrides (hardware, extra pkgs/home)
overlays/                # pkgs.stable overlay + 3rd-party overlays
```

## Hosts

- **thinkpad-nixos**: Primary dev machine, uses `./features` + `./packages`
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
- **Dotfiles** are symlinked via `mkSymlinks` out-of-store like so:
  - `~/` -> `./home/dotfiles/home/`
  - `~/.config/` -> `./home/dotfiles/dot-config/`
  - This allows live editing of dotfiles **without having to rebuild with Nix** for the edits to reflect
  - When adding a new dotfile, make sure to run `jj status` (which does `git add` internally) for it to get included by Nix

## Important documentation links

- Desktop shell: [DankMaterialShell](https://danklinux.com/docs)
- Compositor: [Hyprland](https://wiki.hypr.land/Configuring/). Note that I'm using a newer Hyprland version (0.55+) which means that its configuration language is Lua instead of the old Hyprlang.
