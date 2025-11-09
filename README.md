# NixOS configuration

## Installation

```sh
hostname=nixos # Set your hostname here
config_path=~/.config/nixos

nix-shell -p git home-manager
sudo true
git clone https://github.com/mawkler/nixos.git $config_path
sudo mv /etc/nixos/ /etc/nixos-old/
sudo ln -s $config_path /etc/
mkdir -p $config_path/hosts/$hostname
cp /etc/nixos-old/hardware-configuration.nix $config_path/hosts/$hostname

sudo hostname $hostname
sudo nixos-rebuild switch
curl -s https://raw.githubusercontent.com/mawkler/dotfiles/master/.dotfiles/install-dotfiles.sh | bash
home-manager switch --flake ~/.config/nixos#melker@$hostname --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```
