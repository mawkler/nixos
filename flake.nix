{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    caelestia.url = "github:caelestia-dots/shell";
    caelestia.inputs.nixpkgs.follows = "nixpkgs";

    nixai.url = "github:olafkfreund/nix-ai-help";
    nixai.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    minimal-tmux.url = "github:niksingh710/minimal-tmux-status";
    minimal-tmux.inputs.nixpkgs.follows = "nixpkgs";

    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    nix-search-tv.inputs.nixpkgs.follows = "nixpkgs";

    nox.url = "github:madsbv/nix-options-search";
    nox.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
      system = "x86_64-linux";
    in {
      nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs overlays; };
        modules = [ ./configuration.nix ./packages ];
      };

      homeConfigurations.melker = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs overlays; };
        modules = [ ./home ];
      };
    };
}
