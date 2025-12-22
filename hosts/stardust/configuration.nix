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

  # UEFI Configuration (recommended)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 5;

  # Enable virtual box guest additions services
  virtualisation.virtualbox.guest.enable = true;
  nixpkgs.config.virtualbox.host.enableExtensionPack = true;

  # Ensure the VMWare/VirtualBox graphics driver is loaded early
  boot.initrd.kernelModules = [ "vmwgfx" ];

  # If you use GNOME/KDE, ensure they don't try to use 3D features that don't exist
  environment.variables = {
    # Forces software rendering for apps that struggle in the VM
    "WLR_NO_HARDWARE_CURSORS" = "1";
    "LIBGL_ALWAYS_SOFTWARE" = "1"; 
  };
}

