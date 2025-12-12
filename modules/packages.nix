{ config, pkgs, specialArgs, ... }:

let
  unstablePkgs = specialArgs.unstablePkgs;
in
{
  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];

  

  # System-wide packages
  environment.systemPackages = with pkgs; [
    wget
    nano
    parsec-bin
    kdePackages.dolphin
    vscode
    efibootmgr
    nixd
    direnv
    lshw
    alacritty
    git
    gnumake
    pciutils
    fastfetch

    winetricks
    wineWowPackages.waylandFull
    unzip
    quickshell
    ytmdesktop


    lutris
    protontricks
    gamemode
    mangohud
    steam-run

    wofi
    hyprpaper
    hypridle
    hyprcursor
    hyprlock
    hyprsysteminfo
    hyprpolkitagent

    appimage-run
    btop

    micro-full

    prismlauncher
    # stremio old qtwebengine, unsecure
    qbittorrent-enhanced
    ryubing
    discord-ptb
    jetbrains-toolbox
    ffmpeg-full
    mako
    wlogout
    nixfmt-rfc-style

    brightnessctl

    flatpak
    warehouse
  ];
}