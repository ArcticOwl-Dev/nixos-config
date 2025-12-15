# Brave browser configuration module
{ config, lib, pkgs, ... }:
{
  programs.brave = {
    enable = true;
    package = pkgs.brave;
  };
}