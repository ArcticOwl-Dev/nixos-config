# Boot loader configuration module
# Supports both BIOS and UEFI, with BIOS Boot Partition for GPT disks
{ config, lib, pkgs, ... }:
{
   
    boot.loader.grub.enable = true;
    boot.loader.grub.efiSupport = false;
    boot.loader.grub.useOSProber = true;
    boot.loader.timeout = 5;
    boot.loader.grub.timeoutStyle = "menu";
  
}

