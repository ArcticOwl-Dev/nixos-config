# NixOS configuration for stardust
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "stardust";

  users.users = {
    r00t = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123456";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };
  };

  # Home Manager user configuration
  home-manager.users.r00t = import ./home.nix;

  # Enable virtual box guest additions services
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.host.enableExtensionPack = true;
}

