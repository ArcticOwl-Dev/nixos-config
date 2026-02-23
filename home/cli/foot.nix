{ config, lib, pkgs, style, ... }:
let
  nerdFont = style.nerdFont;
in
{
  # Configure foot terminal (simpler, more reliable on Wayland)
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${nerdFont}:size=12";
        shell = "${pkgs.fish}/bin/fish";  # Explicitly use fish shell
      };
    };
  };
}