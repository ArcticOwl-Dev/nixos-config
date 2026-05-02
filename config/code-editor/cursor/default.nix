# Cursor code editor configuration
{ config, lib, pkgs, inputs, ... }:
{
  nix.nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

  environment.systemPackages = [
    pkgs.code-cursor
    pkgs.nixd
  ];
}