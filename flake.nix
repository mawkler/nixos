{
  description = "NixOS system configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    neovim.url = "path:/home/melker/.config/nvim";

    # No `nixpkgs.follows`, or the kernel won't hit Chaotic-Nyx's binary cache
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    minimal-tmux.url = "github:niksingh710/minimal-tmux-status";
    minimal-tmux.inputs.nixpkgs.follows = "nixpkgs";

    nix-search-tv.url = "github:3timeslazy/nix-search-tv";
    nix-search-tv.inputs.nixpkgs.follows = "nixpkgs";

    # 2026-11-08: build failure
    # nox.url = "github:madsbv/nix-options-search";
    # nox.inputs.nixpkgs.follows = "nixpkgs";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";

    jaunt.url = "git+file:///home/melker/jaunt";
    jaunt.inputs.nixpkgs.follows = "nixpkgs";

    lig.url = "github:KevenGoncalves/lig";
    lig.inputs.nixpkgs.follows = "nixpkgs";

    # nix-serve binary caches between the hosts, started on demand. No inputs
    nix-servant.url = "github:mawkler/nix-servant";

    dank-material-shell.url = "github:AvengeMedia/DankMaterialShell";
    dank-material-shell.inputs.nixpkgs.follows = "nixpkgs";

    dms-plugin-registry.url = "github:AvengeMedia/dms-plugin-registry";
    dms-plugin-registry.inputs.nixpkgs.follows = "nixpkgs";

    dux-files.url = "github:duxlabs-dev/dux-files";
    dux-files.inputs.nixpkgs.follows = "nixpkgs";

    vicinae-extensions.url = "github:vicinaehq/extensions";
    vicinae-extensions.inputs.nixpkgs.follows = "nixpkgs";

    kache.url = "github:kunobi-ninja/kache/stable";
    kache.inputs.nixpkgs.follows = "nixpkgs";

    # LLM agent skills
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
    skills.url = "github:mawkler/agent-skills";
    skills.flake = false;

    rust-skills.url = "github:actionbook/rust-skills";
    rust-skills.flake = false;

    ponytail.url = "github:DietrichGebert/ponytail";
    ponytail.flake = false;
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    let
      overlays = import ./overlays { inherit inputs; };
      specialArgs = {
        inherit
          inputs
          overlays
          username
          rootPath
          ;
      };
      system = "x86_64-linux";
      username = "melker";
      rootPath = "/home/melker/.config/nixos";

      # The keys double as hostnames, which are used in `trusted-substituters`
      # in nix-serve
      hosts = {
        thinkpad-nixos = [
          ./features/core.nix
          ./features/laptop.nix
          ./packages
        ];

        beauty = [
          ./features/core.nix
          ./features/gpu/nvidia.nix
          ./features/ssh.nix
          ./packages
        ];

        framework13-df = [
          ./features/core.nix
          ./packages
          ./hosts/framework13-df/packages
        ];
      };

      mkNixosConfigs =
        hosts:
        builtins.mapAttrs (
          hostname: modules:
          nixpkgs.lib.nixosSystem {
            specialArgs = specialArgs // {
              inherit hostname;
              hostnames = builtins.attrNames hosts;
            };
            inherit modules;
          }
        ) hosts;
    in
    {
      # NixOS
      nixosConfigurations = mkNixosConfigs hosts;

      # Home Manager
      homeConfigurations =
        let
          config = hostname: {
            pkgs = nixpkgs.legacyPackages.${system};
            extraSpecialArgs = specialArgs // { inherit hostname; };
          };
        in
        {
          "${username}@thinkpad-nixos" = home-manager.lib.homeManagerConfiguration (
            config "thinkpad-nixos"
            // {
              modules = [
                ./home
                ./home/dank-material-shell.nix
                ./home/vicinae.nix
              ];
            }
          );

          "${username}@beauty" = home-manager.lib.homeManagerConfiguration (
            config "beauty"
            // {
              modules = [
                ./home
                ./home/dank-material-shell.nix
                ./home/vicinae.nix
              ];
            }
          );

          "${username}@framework13-df" = home-manager.lib.homeManagerConfiguration (
            config "framework13-df"
            // {
              modules = [
                ./home
                ./hosts/framework13-df/home
              ];
            }
          );
        };
    };
}
