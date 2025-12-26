# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
  ];

  networking.hostName = "snowfire";

    users.users = {
    r00t = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123456";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  # Home Manager user configuration (integrated into NixOS)
  # Automatically imports base home/home.nix and host-specific home.nix
  home-manager.users.r00t = {
    imports = [
      ../../home/home.nix  # Base home configuration (shared across all hosts)
      ./home.nix           # Host-specific home configuration
    ];
  };

}

