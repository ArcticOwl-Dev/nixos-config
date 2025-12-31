{ config, pkgs, lib, style, ... }:
let
  waybarConfigPath = ./config.json;
  waybarStylePath = ./style.css;
in
{
  # Ensure icon theme packages are available
  home.packages = with pkgs; [
    papirus-icon-theme
    hicolor-icon-theme
  ];

  # Configure GTK icon theme for waybar to display application icons
  # Papirus has more application icons (YouTube, Twitch, etc.)
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      target = "hyprland-session.target";
    };
    settings = [ (builtins.fromJSON (builtins.readFile waybarConfigPath)) ];
    style = builtins.readFile waybarStylePath;
  };

  # Configure systemd service environment for waybar to find icons and desktop entries
  # This ensures waybar can locate application icons from the icon theme
  # XDG_DATA_DIRS is needed to find desktop entries for window matching
  systemd.user.services.waybar.Service.Environment = [
        "GTK_ICON_THEME=Papirus-Dark"
        "XDG_DATA_DIRS=${config.home.profileDirectory}/share:/run/current-system/sw/share"
      ];

  # Force overwrite existing waybar config files
  # This ensures Home Manager overwrites existing files instead of failing
  xdg.configFile."waybar/config" = {
    force = true;
    text = builtins.readFile waybarConfigPath;
  };
  xdg.configFile."waybar/style.css" = {
    force = true;
    source = waybarStylePath;
  };

  # Create waybar toggle script
  home.file.".config/waybar/toggle.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Toggle waybar visibility
      
      if systemctl --user is-active --quiet waybar; then
        systemctl --user stop waybar
      else
        systemctl --user start waybar
      fi
    '';
  };
  home.file.".config/waybar/focus-window.sh" = {
    executable = true;
    text = ''
      #!/bin/sh

      address=$1

      # https://api.gtkd.org/gdk.c.types.GdkEventButton.button.html
      button=$2

      if [ $button -eq 1 ]; then
          # Left click: focus window
          hyprctl keyword cursor:no_warps true
          hyprctl dispatch focuswindow address:$address
          hyprctl keyword cursor:no_warps false
      elif [ $button -eq 2 ]; then
          # Middle click: close window
          hyprctl dispatch closewindow address:$address
      fi
    '';
  };

  # start waybar on hyprland startup
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = waybar
  '';
}

