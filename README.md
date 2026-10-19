# NixOS configuration

## Installation

1. Clone this repo

   ```sh
   nix-shell --packages git --run 'git clone https://github.com/mawkler/nixos.git ~/.config/nixos'
   ```
2. Add an entry for your machine's hostname to this repo's `flake.nix` (both to the NixOS and Home Manager section)
3. Install the NixOS and Home-Manager config :

   (**2026-10-20:** I've made some improvements here, but haven't actually been able to try running them yet)

   ```sh
   nix-shell --packages git --run '
     set -e
     hostname=beauty # Set your hostname here (make sure that it matches the name used in step 2)
     config_path=~/.config/nixos
     export NIX_CONFIG="extra-experimental-features = nix-command flakes pipe-operators"

     echo "Cloning local flake inputs..."
     git clone https://github.com/mawkler/nvim.git ~/.config/nvim

     echo "Linking NixOS config..."
     sudo mv /etc/nixos/ /etc/nixos-old/
     sudo ln -s $config_path /etc/nixos
     mkdir -p $config_path/hosts/$hostname
     cp /etc/nixos-old/hardware-configuration.nix $config_path/hosts/$hostname
     git -C $config_path add hosts/$hostname

     echo "Installing NixOS config..."
     sudo nixos-rebuild switch --flake $config_path#$hostname \
       --option extra-experimental-features "nix-command flakes pipe-operators" \
       --option extra-substituters "https://nyx-cache.chaotic.cx/" \
       --option extra-trusted-public-keys "nyx-cache.chaotic.cx:dJxTrgMC3V3cFfyIiBQDQorG6k1LsqurH/srpMSq7qk="

     echo "Installing Home Manager config..."
     nh home switch $config_path --configuration $USER@$hostname
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
