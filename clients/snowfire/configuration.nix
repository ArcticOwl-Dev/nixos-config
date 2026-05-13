# NixOS configuration for snowfire
{ lib, pkgs, ... }:
{
  imports = [
     ./hardware-configuration.nix
     ../../config/desktop/plasma/plasma.nix 

     ../../config/general/sound.nix
     ../../config/general/i18n.nix
     ../../config/general/printer.nix
     ../../config/general/scanner.nix

     ../../config/remote-touchpad/remote-touchpad.nix
     ../../config/virtualisation/winapps-vm.nix
     ../../config/vpn/tailscale.nix
     ../../config/games/steam.nix
     ../../config/secrets/sops-nix.nix
     
  ];

  networking.hostName = "snowfire";

  # =============================================================================
  # Firewall, Fonts
  # =============================================================================
  networking.firewall.enable = true; 
  fonts.fontDir.enable = true;
  
  # =============================================================================
  # Users
  # =============================================================================
  users.users = {
    r00t = {
      # If you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # Be sure to change it (using passwd) after rebooting!
      initialPassword = "123456";
      isNormalUser = true;
      extraGroups = [
        "networkmanager" # Needed to manage network connections (WiFi, etc.)
        "wheel"          # Gives sudo/admin access
        "libvirtd"       # Required for managing libvirt/QEMU/KVM virtual machines
        "kvm"            # Provides access to hardware virtualization features
        "lp"             # Gives permission to manage printers (needed for printing)
        "scanner"        # Gives permission to manage scanners (needed for scanning)
      ];
      shell = pkgs.fish;
    };
  };
  programs.fish.enable = true;  
  security.sudo.extraConfig = ''
    Defaults pwfeedback
  '';

  # =============================================================================
  # Nix: Garbage Collection
  # =============================================================================
  nix.gc = {
    automatic = true;
    options = "--delete-older-than 30d";  # Keep generations for 30 days (adjust as needed)
    dates = "weekly";  # Run GC weekly
  };

  # =============================================================================
  # Virtualisation: Libvirt + virt-manager - for WinApps (Windows VM backend)
  # =============================================================================
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


  # =============================================================================
  # Boot: GRUB (UEFI), Plymouth splash, quiet boot
  # =============================================================================
  boot.loader = {
    systemd-boot.enable = false;
    timeout = 3;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = false;
      configurationLimit = 30;
      configurationName = lib.mkDefault "";
      copyKernels = true;
      memtest86.enable = false;
    };
    grub2-theme = {
      enable = true;
      theme = "vimix";
      footer = true;
      customResolution = "5120x1440";
    };
  };

  #TODO: Dont Work currently
  boot.plymouth = {
    enable = true;
    theme = "cuts";
    themePackages = [ pkgs.local.plymouth-theme-cuts ];
  };

  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=auto"
    "splash"
    "boot.shell_on_fail"
  ];
  boot.consoleLogLevel = 4;
  boot.initrd.verbose = false;

  boot.kernelPackages = pkgs.linuxPackages_latest;

}

