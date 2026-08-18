# NixOS configuration

## Installation

1. Clone this repo

   ```sh
   config_path=~/.config/nixos
   nix run nixpkgs#git clone https://github.com/mawkler/nixos.git $config_path
   ```
2. Add an entry for your machine's hostname to this repo's `flake.nix` (both to the NixOS and Home Manager section)
3. Install the NixOS and Home-Manager config :

   (**2026-08-25:** I've made some improvements here, but haven't actually been able to try running them yet)

   ```sh
   nix-shell --packages git home-manager --run '
     set -e
     hostname=beauty # Set your hostname here (make sure that it matches the name used in step 2)
     config_path=~/.config/nixos

     echo "Cloning NixOS config..."
     sudo true
     sudo mv /etc/nixos/ /etc/nixos-old/
     sudo ln -s $config_path /etc/
     mkdir -p $config_path/hosts/$hostname
     cp /etc/nixos-old/hardware-configuration.nix $config_path/hosts/$hostname
     git add $config_path/hosts/$hostname

     echo "Installing NixOS config"
     sudo hostname $hostname
     sudo true
     nh os switch ~/.config/nixos -- \
       --option substituters "https://attic.xuyh0120.win/lantian" \
       --option trusted-public-keys "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" \
       --extra-experimental-features "nix-command flakes"
     nh home switch ~/.config/nixos

     echo "Installing Neovim configuration"
     git clone https://github.com/mawkler/nvim.git ~/.config/nvim
   '
   ```

### Binary cache keys

Generate binary cache keys for `nix-serve`:

  ```fish
  #!/usr/bin/env fish
  sudo mkdir -p /var/secrets/nix-serve
  sudo nix-store --generate-binary-cache-key \
    cache.(hostname).local-1 \
    /var/secrets/nix-serve/secret.key \
    /var/secrets/nix-serve/public.key

  cat /var/secrets/nix-serve/public.key | wl-copy
  echo "Public key is now in clipboard. Paste it into the `trusted-public-keys` field in `features/nix-serve.nix`"
  ```
