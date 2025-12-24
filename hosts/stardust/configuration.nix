# NixOS configuration for stardust
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ./hardware-configuration.nix

    #Hyprland desktop configuration 
    ../../nixos/desktop/hyprland

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

  # Home Manager user configuration (integrated into NixOS)
  # Automatically imports base home/home.nix and host-specific home.nix
  home-manager.users.r00t = {
    extraSpecialArgs = {
      # Import host-specific style configuration
      style = import ./style.nix;
    };
    imports = [
      ../../home/home.nix  # Base home configuration (shared across all hosts)
      ./home.nix           # Host-specific home configuration
    ];
  };

  # UEFI Configuration (recommended)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  # Enable vmware guest services
  virtualisation.vmware.guest.enable = true;

}

