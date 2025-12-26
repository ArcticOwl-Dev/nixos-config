# Home Manager configuration for stardust
{ config, lib, pkgs, inputs, style, ... }:
{
  imports = [
   # ../../home/browser/brave.nix
    ../../home/browser/firefox.nix

    ../../home/cli/cli.nix
    ../../home/cli/git.nix

    ../../home/desktop/hyprland/hyprland.nix
    ../../home/desktop/wlogout.nix
    ../../home/desktop/hyprlock.nix
    ../../home/desktop/waybar.nix
    
    ../../home/appLauncher/walker.nix
    ../../home/appLauncher/vicinae.nix
  ];

  home = {
    username = "r00t";
    homeDirectory = "/home/r00t";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}

