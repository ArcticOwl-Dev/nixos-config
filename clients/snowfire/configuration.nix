# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ../../nixos/desktop/hyprland
     ../../nixos/sound/default.nix
     ../../nixos/i18n/default.nix
     ../../nixos/remote-touchpad/remote-touchpad.nix
  ];

  networking.hostName = "snowfire";

  # Enable firewall
  networking.firewall.enable = true;
  
  users.users = {
    r00t = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123456";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      # Note: "uinput" group is automatically added by services.unified-remote
    };
  };

    # UEFI Configuration (recommended)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  fonts.fontDir.enable = true;


}

