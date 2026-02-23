# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ../../config/desktop/plasma
     ../../config/sound/default.nix
     ../../config/i18n/default.nix
     ../../config/remote-touchpad/remote-touchpad.nix
     ../../config/virtualisation/winapps-vm.nix

     ../../config/games/steam.nix
  ];

  networking.hostName = "snowfire";

  # Libvirt + virt-manager - for WinApps (Windows VM backend)
  virtualisation.libvirtd.enable = true;
  virtualisation.libvirtd.qemu.vhostUserPackages = [ pkgs.virtiofsd ];  # Required for virtio-fs shared folders
  programs.virt-manager.enable = true;
  environment.systemPackages = [ pkgs.virt-manager ];


  # WinApps Windows VM - declarative libvirt domain
  # Download Windows ISO and VirtIO ISO, then set paths:
  #   Windows: https://www.microsoft.com/software-download
  #   VirtIO:  https://fedorapeople.org/groups/virt/virtio-win/direct-downloads/latest-virtio/virtio-win.iso
  virtualisation.winappsVm = {
    enable = true;
    vmName = "RDPWindows";
    memory = 4096;
    vcpus = 4;
    diskSizeG = 64;
    windowsIso = "/tmp/tiny11_25H2_Nov25.iso";                  # EDIT: your path
    virtioIso = "/tmp/virtio-win-0.1.285.iso";                  # EDIT: your path
  };






  # Enable firewall
  networking.firewall.enable = true;
  fonts.fontDir.enable = true;
  
  users.users = {
    r00t = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123456";
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel" "libvirtd" "kvm"];
      # Note: "uinput" group is automatically added by services.unified-remote
    };
  };

  users.users.r00t.shell = pkgs.fish;
  programs.fish.enable = true;

  # GRUB2 Boot Loader Configuration (UEFI)
  boot.loader.systemd-boot.enable = false;  # Disable systemd-boot
  boot.loader.grub = {
    enable = true;
    device = "nodev";  # Use EFI variables instead of installing to a device
    efiSupport = true;
    useOSProber = false;  # Enable OS prober to detect other OSes
    # Manual Windows 10 entry (if os-prober doesn't detect it)
    # Windows is on /dev/nvme0n1p3 (UUID: CADA2361DA2348D1)
    # Note: If bootmgfw.efi is not found, Windows boot files might be on a different EFI partition
    # or Windows might need to be booted directly from UEFI firmware
    extraEntries = ''
      menuentry "Windows 10" {
        insmod part_gpt
        insmod fat
        insmod search_fs_uuid
        insmod chain
        # Try EFI partition first
        search --fs-uuid --set=root 9FFC-7BDD
        # If bootmgfw.efi doesn't exist here, you may need to:
        # 1. Check other EFI partitions (like sdd1)
        # 2. Boot Windows directly from UEFI firmware (F12 or similar at boot)
        # 3. Or manually copy Windows boot files to this EFI partition
        chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 10;
  
  # Ensure os-prober package is available for Windows detection
  boot.loader.grub.configurationLimit = 30;  # Keep more GRUB entries

  # Plymouth boot splash screen with cuts theme
  boot.plymouth = {
    enable = true;
    theme = "cuts";
    themePackages = [ pkgs.local.plymouth-theme-cuts ];
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

