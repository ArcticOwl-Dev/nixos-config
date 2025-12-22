# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  # If you need hardware-configuration.nix, generate it with:
  # nixos-generate-config --dir ./hosts/snowfire
  # imports = [
  #   ./hardware-configuration.nix
  # ];

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

  # Home Manager user configuration
  home-manager.users.r00t = import ./home.nix;

}

