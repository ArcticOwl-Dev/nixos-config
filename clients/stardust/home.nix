# Home Manager configuration for stardust
{ config, lib, pkgs, inputs, style, ... }:
{
  imports = [
    ../../home/browser/brave.nix
    ../../home/browser/firefox.nix

    ../../home/cli/cli.nix
    ../../home/cli/git.nix

    ../../home/desktop/hyprland/hyprland.nix
    ../../home/desktop/wlogout.nix
    ../../home/desktop/hyprlock.nix
    ../../home/desktop/waybar/waybar.nix
    
    ../../home/appLauncher/walker.nix
    ../../home/appLauncher/vicinae.nix
  ];

  home = {
    username = "r00t";
    homeDirectory = "/home/r00t";
  };

  home.packages = with pkgs; [
    unified-remote
  ];

  # Machine-specific Home Manager configuration for stardust
  # Add your stardust-specific user settings here
}

