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
  boot.kernelParams = [
  "i915.enable_dpcd_backlight=1"
  "acpi_backlight=native"
];

  # These are moved to graphics.nix as they are NVIDIA-specific
  # boot.blacklistedKernelModules = [ "nouveau" ];
  # boot.kernelParams = [ "nvme_core.default_ps_max_latency_us=0" ];

  boot.loader.grub.theme = pkgs.stdenv.mkDerivation {
  pname = "distro-grub-themes";
  version = "3.1";
  src = pkgs.fetchFromGitHub {
    owner = "AdisonCavani";
    repo = "distro-grub-themes";
    rev = "v3.1";
    hash = "sha256-ZcoGbbOMDDwjLhsvs77C7G7vINQnprdfI37a9ccrmPs=";
  };
  installPhase = "cp -r customize/nixos $out";
};

}