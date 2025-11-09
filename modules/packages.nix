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
    kdePackages.qtsvg
    vscode
    wget
    efibootmgr
    kitty
    nixpkgs-fmt
    nixd
    direnv
    lshw
    alacritty
    git
    home-manager
    gnumake
    pciutils
    fastfetch

    # native wayland support (unstable)
    winetricks
    wineWowPackages.stable
    wineWowPackages.waylandFull
    wineWowPackages.staging
    unzip
    unstablePkgs.quickshell

    # Qt6 related kits（for slove Qt5Compat problem）
    qt6.qt5compat
    qt6.qtbase
    qt6.qtquick3d
    qt6.qtwayland
    qt6.qtdeclarative
    qt6.qtsvg
    qt6.full
    qtcreator

    # alternate options
    # libsForQt5.qt5compat
    kdePackages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    lutris
    protontricks
    winetricks
    gamemode
    mangohud
    steam-run

    wofi
    hyprpaper
    hypridle
    hyprlock
    appimage-run
    hyprsysteminfo
    hyprpolkitagent
    monado
    nil

    btop
    icu

    micro-full

    # zed-editor
    prismlauncher
    librsvg
    stremio
    qbittorrent-enhanced
    ryubing
    gimp
    discord-ptb
    jetbrains-toolbox
    ffmpeg-full
    mako
    wlogout
    nixfmt-classic

  
    bottles
  ];
}