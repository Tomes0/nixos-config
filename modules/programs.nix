{ config, pkgs, specialArgs, ... }:

let
  unstablePkgs = specialArgs.unstablePkgs;
in
{
  # VR Applications
  programs.alvr = {
    enable = true;
    openFirewall = true;
  };
  services.wivrn = {
    enable = true;
    openFirewall = true;
    package = unstablePkgs.wivrn;
  };

  # Standard Applications
  programs.kdeconnect.enable = true;
  services.flatpak.enable = true;
  programs.firefox.enable = true;
  programs.envision = {
    enable = true;
    openFirewall = true;
  };

  # Gaming
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

}