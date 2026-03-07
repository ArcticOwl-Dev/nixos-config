{ config, lib, pkgs, inputs, ... }:
{
  home.packages = [ inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser ];
}