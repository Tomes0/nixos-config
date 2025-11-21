{ config, pkgs, ... }:

{
  # Audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Input devices
  services.libinput.enable = true;

  # Hardware-specific services
  services.asusd = {
    enable = true;
    enableUserService = true;
  };
  services.upower.enable = true;

  # Storage and media
  services.udisks2.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.settings = {
    General = {
      Enable = "Source,Sink,Media,Socket";
    };
  };
}