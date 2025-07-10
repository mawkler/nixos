{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprshell.url = "github:H3rmt/hyprshell?ref=hyprshell-release";
    hyprshell.inputs.nixpkgs.follows = "nixpkgs";
    walker.url = "github:abenz1267/walker";
    nixai.url = "github:olafkfreund/nix-ai-help";
    stylix.url = "github:nix-community/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let overlays = import ./overlays { inherit inputs; };
    in {
      nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          inherit overlays;
        };

        modules = with inputs; [
          ./configuration.nix
          ./packages
          nixai.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };

      homeConfigurations.melker = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home ];
      };
    };
}
