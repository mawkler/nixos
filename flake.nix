{
  description = "NixOS system configuration";

  inputs = { nixpkgs.url = "nixpkgs/nixos-unstable"; };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./configuration.nix ];
    };
  };
}
