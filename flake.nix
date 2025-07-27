{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs-stable";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs-stable";
    hyprshell.url = "github:H3rmt/hyprshell?ref=hyprshell-release";
    hyprshell.inputs.nixpkgs.follows = "nixpkgs-stable";
    walker.url = "github:abenz1267/walker";
    nixai.url = "github:olafkfreund/nix-ai-help";
    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs-unstable";
    minimal-tmux.url = "github:niksingh710/minimal-tmux-status";
    minimal-tmux.inputs.nixpkgs.follows = "nixpkgs-stable";
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    nox.url = "github:madsbv/nix-options-search";
    nox.inputs.nixpkgs.follows = "nixpkgs-stable";
  };

  outputs = { nixpkgs-stable, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
      system = "x86_64-linux";
    in {
      nixosConfigurations.thinkpad-nixos = nixpkgs-unstable.lib.nixosSystem {
        specialArgs = { inherit inputs overlays; };
        modules = with inputs; [
          ./configuration.nix
          ./packages
          nixai.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };

      homeConfigurations.melker = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs-stable.legacyPackages.${system};
        extraSpecialArgs = { inherit inputs; };
        modules = [ ./home ];
      };
    };
}
