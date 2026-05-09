{ config, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}