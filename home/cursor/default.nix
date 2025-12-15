# Cursor editor configuration module
{ config, lib, pkgs, ... }:
{
  programs.cursor = {
    enable = true;
    settings = {
      "editor.fontFamily" = "JetBrains Mono";
      "editor.fontSize" = 14;
    };
  };
}