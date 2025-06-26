{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    hyprshell.url = "github:H3rmt/hyprshell?ref=hyprshell-release";
    hyprshell.inputs.nixpkgs.follows = "nixpkgs";
    nixai.url = "github:olafkfreund/nix-ai-help";
  };

  outputs = { nixpkgs, nixai, ... }@inputs:
    let overlays = import ./overlays { inherit inputs; };
    in {
      nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit overlays;
        };
        modules = [ ./configuration.nix ./packages nixai.nixosModules.default ];
      };
    };
}
