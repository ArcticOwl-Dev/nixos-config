# Scripts module - manages custom scripts and adds them to PATH
{ config, lib, pkgs, ... }:
let
  # Directory where scripts will be stored in home directory
  scriptsDir = ".local/bin";
in
{
  # Add scripts directory to PATH
  home.sessionVariables = {
    PATH = "$HOME/${scriptsDir}:$PATH";
  };

  # Define your scripts here
  # Place script files in this directory (home/scripts/) and reference them below
  # Or define scripts directly using the pattern shown in the examples

  # nix-mutable: Convert Nix-managed symlinks to mutable files
  home.file."${scriptsDir}/nix-mutable" = {
    source = ./nix-mutable.sh;
    executable = true;
  };

  # get-window-info: Get window class and title for waybar configuration
  home.file."${scriptsDir}/get-window-info" = {
    source = ./get-window-info.sh;
    executable = true;
  };

  # Example: If you have a script file in this directory, reference it like this:
  # home.file."${scriptsDir}/my-script.sh" = {
  #   source = ./my-script.sh;
  #   executable = true;
  # };

  # Example: Define a script directly in Nix:
  # home.file."${scriptsDir}/my-script.sh" = {
  #   executable = true;
  #   text = ''
  #     #!/usr/bin/env bash
  #     # Your script content here
  #     echo "Hello from my script!"
  #   '';
  # };
}

