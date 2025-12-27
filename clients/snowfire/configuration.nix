# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ./session.nix
     ../../config/desktop/hyprland
     ../../config/sound/default.nix
     ../../config/i18n/default.nix
     ../../config/remote-touchpad/remote-touchpad.nix
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
  boot.loader.timeout = 2;

  # Quiet boot - hide startup messages, only show errors
  boot.kernelParams = [
    "quiet"
    "loglevel=3"  # Only show errors (0=emergency, 1=alert, 2=critical, 3=error, 4=warning, 5=notice, 6=info, 7=debug)
    "systemd.show_status=auto"  # Only show status on errors or slow boots
  ];
  boot.consoleLogLevel = 4;  # Only show errors and warnings on console
  boot.initrd.verbose = false;  # Reduce initrd verbosity

  fonts.fontDir.enable = true;

  # Configure greetd for auto-login (handled by session.nix)
  host = {
    gui.enable = true;
    hyprland.enable = true;
  };

}

