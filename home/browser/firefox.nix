{ config, lib, pkgs, ... }:
{
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    settings = {
      "browser.startup.homepage" = "https://www.google.com";
      "browser.startup.page" = 1;
    };
  };
}