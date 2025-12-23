# Home Manager configuration for stardust
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ../../home/browser/brave
    ../../home/cli
    ../../home/git
    ../../home/desktop/hyprland.nix
    ../../home/desktop/wlogout.nix
    ../../home/desktop/hyprlock.nix
    ../../home/desktop/wlogout.nix
    ../../home/appLauncher/walker.nix
  ];

  home = {
    username = "r00t";
    homeDirectory = "/home/r00t";
  };

  # Machine-specific Home Manager configuration for stardust
  # Add your stardust-specific user settings here
}

