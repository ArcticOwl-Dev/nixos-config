# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ../../config/desktop/hyprland
     ../../config/sound/default.nix
     ../../config/i18n/default.nix
     ../../config/remote-touchpad/remote-touchpad.nix
  ];

  networking.hostName = "snowfire";

  # Enable firewall
  networking.firewall.enable = true;
  fonts.fontDir.enable = true;
  
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




  # GRUB2 Boot Loader Configuration (UEFI)
  boot.loader.systemd-boot.enable = false;  # Disable systemd-boot
  boot.loader.grub = {
    enable = true;
    device = "nodev";  # Use EFI variables instead of installing to a device
    efiSupport = true;
    useOSProber = true;  # Enable OS prober to detect other OSes
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  # Plymouth boot splash screen with cuts theme
  boot.plymouth = {
    enable = true;
    theme = "cuts";
    themePackages = [ (pkgs.callPackage ../../pkgs/plymouth-theme-cuts { }) ];
  };
  # Quiet boot - hide startup messages, only show errors
  boot.kernelParams = [
    "quiet"
    "loglevel=3"  # Only show errors (0=emergency, 1=alert, 2=critical, 3=error, 4=warning, 5=notice, 6=info, 7=debug)
    "systemd.show_status=auto"  # Only show status on errors or slow boots
    "splash"
    "boot.shell_on_fail"
  ];
  boot.consoleLogLevel = 4;  # Only show errors and warnings on console
  boot.initrd.verbose = false;  # Reduce initrd verbosity

  boot.loader.grub2-theme = {
    enable = true;
    theme = "vimix";
    footer = true;
    customResolution = "5120x1440";
  };


}

