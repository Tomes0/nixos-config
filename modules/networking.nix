{ config, pkgs, ... }:

{
  # Hostname
  networking.hostName = "nixos";

  # Network management
  networking.networkmanager.enable = true;
  services.resolved.enable = true;
  services.resolved.dnssec = "allow-downgrade";

  # Firewall settings
  networking.firewall.allowedUDPPorts = [ 2456 2457 2458 25565 37127 ];
  networking.firewall.allowedTCPPorts = [ 2456 2457 2458 25565 37127 ];
}