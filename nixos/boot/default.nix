# Boot loader configuration module
{ config, lib, pkgs, ... }:
{
   
    boot.loader.grub.enable = true;
    boot.loader.grub.device = "/dev/sda";
    boot.loader.grub.useOSProber = true;
    boot.loader.timeout = 0;
    boot.loader.grub.timeoutStyle = "menu";
  
}

