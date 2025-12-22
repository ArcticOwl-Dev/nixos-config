# Git configuration
{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    settings.user.name = "ArcticOwl-Dev";
    settings.user.email = "56565659+ArcticOwl-Dev@users.noreply.github.com";
  };
}
