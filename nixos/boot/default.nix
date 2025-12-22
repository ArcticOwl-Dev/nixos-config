# Boot loader configuration module
# UEFI: Uses systemd-boot (recommended for UEFI)
# BIOS: Uses GRUB with BIOS Boot Partition support
{ config, lib, pkgs, ... }:
{

  
  # Alternative: GRUB with UEFI support (uncomment if you prefer GRUB)
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "nodev"; # For UEFI, use "nodev"
  # boot.loader.grub.efiSupport = true;
  # boot.loader.grub.useOSProber = true;
  # boot.loader.efi.canTouchEfiVariables = true;
  
  # BIOS Configuration (uncomment if using BIOS instead of UEFI)
  # boot.loader.grub.enable = true;
  # boot.loader.grub.device = "/dev/sda"; # Change to your disk
  # boot.loader.grub.efiSupport = false;
  # boot.loader.grub.useOSProber = true;
}

