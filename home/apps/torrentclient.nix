{ config, lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    transmission_4-qt6
  ];
}