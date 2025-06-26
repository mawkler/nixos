{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixai.url = "github:olafkfreund/nix-ai-help";
  };

  outputs = { nixpkgs, nixai, ... }@inputs:
    let overlays = import ./overlays { inherit inputs; };
    in {
      nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit overlays; };
        modules = [ ./configuration.nix nixai.nixosModules.default ];
      };
    };
}
