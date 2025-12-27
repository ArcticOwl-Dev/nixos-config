# NixOS configuration for stardust
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    #Hyprland desktop configuration 
    ../../config/desktop/hyprland

  ];

  networking.hostName = "stardust";

  users.users = {
    r00t = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123456";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.fish;  # Set fish as the default shell
    };
  };
  
  # Add host-specific extraSpecialArgs for home-manager
  # This extends the global extraSpecialArgs from config/configuration.nix
  home-manager.extraSpecialArgs = {
    inherit inputs;
    # Import host-specific style configuration
    style = import ./style.nix;
  };

  # UEFI Configuration (recommended)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  # Enable vmware guest services
  virtualisation.vmware.guest.enable = true;

  fonts.fontDir.enable = true;
}

