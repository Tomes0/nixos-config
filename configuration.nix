{ config, pkgs, specialArgs, ... }:

{
  imports = [
    # Import all the modularized configuration files
    ./modules/core.nix
    ./modules/boot.nix
    ./modules/hardware.nix
    ./modules/networking.nix
    ./modules/desktop.nix
    ./modules/graphics.nix
    ./modules/programs.nix
    ./modules/packages.nix
  ];
}