# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ../../nixos/desktop/hyprland
     ../../nixos/sound/default.nix
     ../../nixos/i18n/default.nix
     
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

    # UEFI Configuration (recommended)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  fonts.fontDir.enable = true;


}

