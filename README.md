# NixOS configuration

## Installation

1. Clone this repo

   ```sh
   config_path=~/.config/nixos
   nix run nixpkgs#git clone https://github.com/mawkler/nixos.git $config_path
   ```
2. Add an entry for your machine's hostname to this repo's `flake.nix` (both to the NixOS and Home Manager section)
3. Temporarily uncomment `boot.kernelPackages = "..."` in `features/cachyos.nix` (because its `nix.settings.substituters` hasn't been built yet, it will try to build the CachyOS kernel from source, which takes hours)
4. Install the NixOS and Home-Manager config:
  ```sh
  nix-shell --packages git home-manager --run '
    hostname=beauty # Set your hostname here (make sure that it matches the name used in step 2)
    config_path=~/.config/nixos

    # Clone NixOS config
    sudo true
    sudo mv /etc/nixos/ /etc/nixos-old/
    sudo ln -s $config_path /etc/
    mkdir -p $config_path/hosts/$hostname
    cp /etc/nixos-old/hardware-configuration.nix $config_path/hosts/$hostname
    git add $config_path/hosts/$hostname

    # Install NixOS config
    sudo hostname $hostname
    sudo true && nh os switch ~/.config/nixos -- --extra-experimental-features "nix-command flakes" && nh home switch ~/.config/nixos

    # Install Neovim configuration
    git clone https://github.com/mawkler/nvim.git ~/.config/nvim
  '
  ```
5. Re-add the line with `boot.kernelPackages = "..."` in `features/cachyos.nix`, and run `nh os switch ~/.config/nixos -- --extra-experimental-features "nix-command flakes"` (now it should use the cached binary)
