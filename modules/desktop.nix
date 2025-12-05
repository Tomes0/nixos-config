{ config, pkgs, ... }:

{
  # Core desktop services
  services.dbus.implementation = "broker";
  services.gvfs.enable = true; # For trash, mounts, etc.
  services.tumbler.enable = true; # Image/video thumbnailing

  

  # Display manager (login screen)
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  


  
  # Hyprland window manager
  programs.hyprland = {
    enable = true;
    withUWSM = true; # For unified Wayland session management
  };

  # PAM configuration for swaylock
  security.pam.services.swaylock = { };

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

  # TMPFILES for configs
  systemd.tmpfiles.rules = [
    "L+  /home/tomi/.config/hypr       -  -  -  -  /home/tomi/.nixos/config/hypr"
    "L+  /home/tomi/.config/quickshell -  -  -  -  /home/tomi/.nixos/config/quickshell"
  ];

  # --- Cursor setup ---
  environment.variables = {
    HYPRCURSOR_THEME = "posy-improved-cursor";
    HYPRCURSOR_SIZE  = "32";
  };

  # User-local fetch of cursor theme
}
