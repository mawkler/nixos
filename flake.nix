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
      username = "melker";
    in {
      nixosConfigurations = {
        thinkpad-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = {
            # TODO: try to refactor this out so we don't have to duplicate it for each host
            inherit inputs overlays;
            hostname = "thinkpad-nixos";
          };
          modules = [ ./configuration.nix ./packages ];
        };

        work-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs overlays;
            hostname = "work-laptop";
          };
          modules =
            [ ./configuration.nix ./packages ./hosts/work-laptop/packages ];
        };
      };

      homeConfigurations = let
        extraSpecialArgs = { inherit inputs overlays; };
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        # TODO: consider having this be a fallback - i.e., just set the username, not the hostname
        "${username}@thinkpad-nixos" =
          home-manager.lib.homeManagerConfiguration {
            inherit extraSpecialArgs pkgs;
            modules = [ ./home ];
          };

        "${username}@work-laptop" = home-manager.lib.homeManagerConfiguration {
          inherit extraSpecialArgs pkgs;
          modules = [ ./home ./hosts/work-laptop/home ];
        };
      };
    };
}
