{config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
    filen-desktop
  ];
}