{
config, pkgs, specialArgs, ...

}:
let

    unstablePkgs = specialArgs.unstablePkgs;
in {


  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;

  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.timeout = 10;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  networking.hostName = "nixos"; # Define your hostname.


  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.
  services.resolved.enable = true;
  services.resolved.dnssec = "allow-downgrade";

  programs.alvr = {
    enable = true;
    openFirewall = true;
  };

  services.wivrn = {
    enable = true;
    openFirewall = true;

    package = unstablePkgs.wivrn;
  };



  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Set your time zone.

  time.timeZone = "Europe/Budapest";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "hu_HU.UTF-8";
    LC_IDENTIFICATION = "hu_HU.UTF-8";
    LC_MEASUREMENT = "hu_HU.UTF-8";
    LC_MONETARY = "hu_HU.UTF-8";
    LC_NAME = "hu_HU.UTF-8";
    LC_NUMERIC = "hu_HU.UTF-8";
    LC_PAPER = "hu_HU.UTF-8";
    LC_TELEPHONE = "hu_HU.UTF-8";
    LC_TIME = "hu_HU.UTF-8";
  };

  # Enable the X11 windowing system.

  # xservices.xserver.enable = true;

  # services.displayManager.sddm.enable = true;

  # services.displayManager.sddm.wayland.enable = true;

  services.udisks2.enable = true;
  services.dbus.implementation = "broker";
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images

  # Enable touchpad support (enabled default in most desktopManager).

  services.libinput.enable = true;
  services.asusd = {
    enable = true;
    enableUserService = true;
  };

  users.users.tomi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" ]; # sudo + NVENC access
  };


  programs.xfconf.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  programs.kdeconnect.enable = true;
  programs.file-roller.enable = true;
  programs.firefox.enable = true;
   programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    remotePlay.openFirewall = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  }; 


  networking.firewall.allowedUDPPorts = [
    2456
    2457
    2458
    25565
    37127
  ];

  networking.firewall.allowedTCPPorts = [
    2456
    2457
    2458
    25565
    37127
  ];


  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
  ];


  environment.systemPackages = with pkgs; [
    wget
    nano
    parsec-bin
    kdePackages.dolphin
    kdePackages.qtsvg
    vscode
    wget
    efibootmgr

    #kitty

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
    solaar
    zed-editor
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
  ];
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;
  hardware.steam-hardware.enable = true;
  

  services.upower.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?

  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";

    };
  };



  services.xserver.videoDrivers = [ "nvidia" ];

  boot.blacklistedKernelModules = [ "nouveau" ];

  boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];

  xdg.portal = {

    enable = true;

    extraPortals = [

      pkgs.xdg-desktop-portal-gtk

    ];

    configPackages = [ pkgs.hyprland ];

  };

  environment.variables = {

    QML_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml";

    QML2_IMPORT_PATH = "${pkgs.qt6.qt5compat}/lib/qt-6/qml:${pkgs.qt6.qtbase}/lib/qt-6/qml";

  };

  # make sure the Qt application is working properly

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD="1";
    __VK_LAYER_NV_optimus="NVIDIA_only";

  };

  programs.envision = {
    enable = true;
    openFirewall = true; # This is set true by default
  };

}
