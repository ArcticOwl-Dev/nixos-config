{ config, lib, pkgs, ... }:
{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
}