{
  description = "My Nixos :D";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak?ref=latest";
    nixpkgs-xr.url = "github:nix-community/nixpkgs-xr";
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";      

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstablePkgs = import nixpkgs-unstable { inherit system; };
    in {
      # NixOS system configuration
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            #./configuration.nix
            ./hardware-configuration.nix
            ./modules/core.nix
            ./modules/boot.nix
            ./modules/hardware.nix
            ./modules/networking.nix
            ./modules/desktop.nix
            ./modules/graphics.nix
            ./modules/programs.nix
            ./modules/packages.nix
          ];
          specialArgs = {
            unstablePkgs = unstablePkgs;
            inputs = self;
          };
          pkgs = pkgs;
        };
      };
    };
}
