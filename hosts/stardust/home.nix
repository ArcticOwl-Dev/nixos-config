# Home Manager configuration for stardust
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    ../../home/browser/brave
    ../../home/desktop/hyperland
  ];

  home = {
    username = "r00t";
    homeDirectory = "/home/r00t";
  };

  # Machine-specific Home Manager configuration for stardust
  # Add your stardust-specific user settings here
}

