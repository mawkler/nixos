{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    quickshell.url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
    quickshell.inputs.nixpkgs.follows = "nixpkgs";
    hyprshell.url = "github:H3rmt/hyprshell?ref=hyprshell-release";
    hyprshell.inputs.nixpkgs.follows = "nixpkgs";
    walker.url = "github:abenz1267/walker";
    nixai.url = "github:olafkfreund/nix-ai-help";
    stylix.url = "github:nix-community/stylix/release-25.05";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    minimal-tmux.url = "github:niksingh710/minimal-tmux-status";
    minimal-tmux.inputs.nixpkgs.follows = "nixpkgs";
    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    nox.url = "github:madsbv/nix-options-search";
    nox.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
      system = "x86_64-linux";
    in {
      nixosConfigurations.thinkpad-nixos = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system overlays; };
        modules = with inputs; [
          ./configuration.nix
          ./packages
          nixai.nixosModules.default
          stylix.nixosModules.stylix
        ];
      };

      homeConfigurations.melker = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs system;
          pkgs-unstable = nixpkgs-unstable.legacyPackages.x86_64-linux;
        };
        modules = [ ./home ];
      };
    };
}
