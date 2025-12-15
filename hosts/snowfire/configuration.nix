# NixOS configuration for snowfire
{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  networking.hostName = "snowfire";

  # Machine-specific NixOS configuration
  # Add your snowfire-specific settings here
}

