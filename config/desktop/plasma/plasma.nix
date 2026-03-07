# Plasma desktop configuration module
{ config, lib, pkgs, ... }:

{
  imports = [ ./sddm.nix ];

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = [
    pkgs.kdePackages.konsole
    pkgs.kdePackages.kate
    pkgs.kdePackages.kwrited
  ];

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gtk 
      pkgs.kdePackages.xdg-desktop-portal-kde 
    ];
    config.common.default = "kde"; # Force KDE as primary
  };
}
