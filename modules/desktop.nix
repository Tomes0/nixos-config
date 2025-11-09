{ config, pkgs, ... }:

{
  # Core desktop services
  services.dbus.implementation = "broker";
  services.gvfs.enable = true; # For trash, mounts, etc.
  services.tumbler.enable = true; # Image/video thumbnailing

  # Display manager (login screen)
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
  #  wayland.enable = true; # Hyprland handles Wayland itself
  };
  # services.displayManager.defaultSession = "hyprland-uwsm";

  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    withUWSM = true; # For unified Wayland session management
  };

  # XDG portals for Wayland and Flatpak integration
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
    configPackages = [ pkgs.hyprland ];
  };
}
