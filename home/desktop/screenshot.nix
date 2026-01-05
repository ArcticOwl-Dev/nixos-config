{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    grim                    # Screenshot tool
    slurp                   # Screenshot tool
  ];

    # Configure satty (screenshot tool) with grim
  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = false;
        early-exit = false;
        copy-command = "wl-copy";
        corner-roundness = 4;
        output-filename = "/tmp/Screenshots/%Y-%m-%d_%H:%M:%S.png";  # Default save location
        default-fill-shapes = true;
        initial-tool = "arrow";
      };
      color-palette = {
        palette = [ "#3498db" "#2ecc40" "#e67e22" "#e74c3c" "#9b59b6" "#f1c40f" ];
      };
    };
  };

  # screenshot-satty: Take a screenshot with slurp and annotate with satty
  # Placed in .config/satty/ to keep screenshot-related scripts organized with satty config
  home.file.".config/satty/screenshot-satty" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      mkdir -p /tmp/Screenshots
      geometry=$(slurp -c '#ff0000ff' -w 1)
      if [ -n "$geometry" ]; then
        grim -g "$geometry" -t ppm - | satty --filename -
      fi
    '';
  };



}