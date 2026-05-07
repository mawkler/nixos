# NixOS configuration

## Installation

1. Clone this repo

   ```sh
   config_path=~/.config/nixos
   git clone https://github.com/mawkler/nixos.git $config_path
   ```
2. Add an entry for your machine's hostname to this repo's `flake.nix` (both to the NixOS and Home Manager section)
3. Install the config
  ```sh
  nix-shell --packages git home-manager --run '
    hostname=beauty # Set your hostname here (make sure that it matches the name used in step 2)
    config_path=~/.config/nixos

    sudo true
    git clone https://github.com/mawkler/nixos.git $config_path
    sudo mv /etc/nixos/ /etc/nixos-old/
    sudo ln -s $config_path /etc/
    mkdir -p $config_path/hosts/$hostname
    cp /etc/nixos-old/hardware-configuration.nix $config_path/hosts/$hostname
    git add $config_path/hosts/$hostname

    sudo hostname $hostname
    sudo nixos-rebuild switch
    home-manager switch --flake ~/.config/nixos#melker@$hostname --impure --extra-experimental-features nix-command --extra-experimental-features flakes
  '
  ```
