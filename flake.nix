{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

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

    raisin.url = "github:mawkler/raisin";
    raisin.inputs.nixpkgs.follows = "nixpkgs";

    dank-material-shell.url = "github:AvengeMedia/DankMaterialShell";
    dank-material-shell.inputs.nixpkgs.follows = "nixpkgs";

    dms-plugin-registry.url = "github:AvengeMedia/dms-plugin-registry";
    dms-plugin-registry.inputs.nixpkgs.follows = "nixpkgs";

    vicinae-extensions.url = "github:vicinaehq/extensions";
    vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";

    ns-tui.url = "github:briheet/ns-tui";
    ns-tui.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
      specialArgs = { inherit inputs overlays username rootPath; };
      system = "x86_64-linux";
      username = "melker";
      rootPath = "/home/melker/.config/nixos";
    in {
      nixosConfigurations = {
        thinkpad-nixos = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs // { hostname = "thinkpad-nixos"; };
          modules = [ ./configuration.nix ./packages ];
        };

        framework13-df = nixpkgs.lib.nixosSystem {
          specialArgs = specialArgs // { hostname = "framework13-df"; };
          modules =
            [ ./configuration.nix ./packages ./hosts/framework13-df/packages ];
        };
      };

      homeConfigurations = let
        pkgs = nixpkgs.legacyPackages.${system};
        config = {
          inherit pkgs;
          extraSpecialArgs = specialArgs;
        };
      in {
        "${username}@thinkpad-nixos" = home-manager.lib.homeManagerConfiguration
          (config // { modules = [ ./home ./home/dank-material-shell.nix ./home/swayidle.nix ]; });

        "${username}@framework13-df" = home-manager.lib.homeManagerConfiguration
          (config // { modules = [ ./home ./hosts/framework13-df/home ]; });
      };
    };
}
