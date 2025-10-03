# NixOS configuration

## Installation

```sh
hostname=nixos # Set your hostname here
path=~/.config/nixos

nix-shell -p git home-manager
sudo true
git clone https://github.com/mawkler/nixos.git $path
sudo mv /etc/nixos/ /etc/nixos-old/
sudo ln -s $path /etc/
mkdir -p $path/hosts/$hostname
cp /etc/nixos-old/hardware-configuration.nix $path/hosts/$hostname

hostname $hostname
echo -n $hostname > .hostname

sudo nixos-rebuild switch
curl -s https://raw.githubusercontent.com/mawkler/dotfiles/master/.dotfiles/install-dotfiles.sh | bash
home-manager switch --flake ~/.config/nixos#melker@$hostname --impure --extra-experimental-features nix-command --extra-experimental-features flakes
```
