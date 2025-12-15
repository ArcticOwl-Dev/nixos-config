# Cursor code editor configuration
{ config, lib, pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.code-cursor
  ];
}