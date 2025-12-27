# Plasma desktop configuration module
{ config, lib, pkgs, ... }:
{
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
  };
  services.displayManager.sddm.wayland.enable = true;
}