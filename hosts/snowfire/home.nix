# Home Manager configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  home = {
    username = "r00t";
    homeDirectory = "/home/r00t";
  };

  # Machine-specific Home Manager configuration
  # Add your snowfire-specific user settings here
}

