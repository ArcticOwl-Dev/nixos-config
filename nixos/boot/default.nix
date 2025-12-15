# Boot loader configuration module
{ config, lib, pkgs, ... }:
{
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
    timeout = 0;
    timeoutStyle = "hidden";
  };
}

