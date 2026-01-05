# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ../../config/desktop/hyprland
     ../../config/sound/default.nix
     ../../config/i18n/default.nix
     ../../config/remote-touchpad/remote-touchpad.nix

     ../../config/games/steam.nix
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
    # Manual Windows 10 entry (if os-prober doesn't detect it)
    # Windows is on /dev/nvme0n1p3 (UUID: CADA2361DA2348D1)
    # Windows boot files should be in the EFI partition
    extraEntries = ''
      menuentry "Windows 10" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        search --fs-uuid --set=root 9FFC-7BDD
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;
  
  # Ensure os-prober package is available for Windows detection
  boot.loader.grub.configurationLimit = 30;  # Keep more GRUB entries

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

  # Generation management - keep more generations for rollback safety
  # This ensures you have multiple bootable generations available in GRUB
  boot.loader.grub.configurationName = lib.mkDefault "";  # Set to "BACKUP" or similar when you want to mark a generation
  boot.loader.grub.copyKernels = true;  # Keep old kernels available for older generations

  # Configure garbage collection to keep more generations
  # This prevents automatic deletion of old generations
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";  # Keep generations for 30 days (adjust as needed)
    dates = "weekly";  # Run GC weekly
  };

  # Keep more system generations (default is usually 3-5)
  # This ensures multiple generations are available in GRUB boot menu
  # You can check current generations with: nix-env --list-generations --profile /nix/var/nix/profiles/system
  boot.loader.grub.memtest86.enable = false;  # Optional: disable if not needed


}

