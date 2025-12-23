{ config, lib, pkgs, ... }:
{
    environment.systemPackages = with pkgs;[
    curlFull
    wget

  ];
}