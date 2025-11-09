{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

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

    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";

    # DankMaterialShell dependencies
    dgop.url = "github:AvengeMedia/dgop";
    dgop.inputs.nixpkgs.follows = "nixpkgs";

    dms-cli.url = "github:AvengeMedia/danklinux";
    dms-cli.inputs.nixpkgs.follows = "nixpkgs";

    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        dgop.follows = "dgop";
        dms-cli.follows = "dms-cli";
      };
    };

  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
      specialArgs = { inherit inputs overlays username; };
      system = "x86_64-linux";
      username = "melker";
    in {
      nixosConfigurations = {
        thinkpad-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs // { hostname = "thinkpad-nixos"; };
          modules = [ ./configuration.nix ./packages ];
        };

        work-laptop = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs // { hostname = "work-laptop"; };
          modules =
            [ ./configuration.nix ./packages ./hosts/work-laptop/packages ];
        };
      };

      homeConfigurations = let
        pkgs = nixpkgs.legacyPackages.${system};
        config = {
          inherit pkgs;
          extraSpecialArgs = specialArgs;
        };
      in {
        # TODO: consider having this be a fallback - i.e., just set the username, not the hostname
        "${username}@thinkpad-nixos" = home-manager.lib.homeManagerConfiguration
          (config // { modules = [ ./home ]; });

        "${username}@work-laptop" = home-manager.lib.homeManagerConfiguration
          (config // { modules = [ ./home ./hosts/work-laptop/home ]; });
      };
    };
}
