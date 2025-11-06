{ config, pkgs, ... }:

{
  # Bootloader settings
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.efi.efiSysMountPoint = "/boot";
  boot.loader.timeout = 10;

  # Kernel settings
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernel.sysctl."kernel.unprivileged_userns_clone" = 1;

  # These are moved to graphics.nix as they are NVIDIA-specific
  # boot.blacklistedKernelModules = [ "nouveau" ];
  # boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];
}