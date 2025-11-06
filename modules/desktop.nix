{ config, pkgs, ... }:

{
  # Core desktop services
  services.dbus.implementation = "broker";
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # X11 and Display Manager
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # Desktop Environments & Window Managers
  services.desktopManager.plasma6.enable = true;
  programs.xfconf.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # XDG Portals for Wayland/Flatpak integration
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.hyprland ];
  };
}