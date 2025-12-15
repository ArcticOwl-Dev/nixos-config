# Git configuration
{ config, lib, pkgs, ... }:
{
  programs.git = {
    enable = true;
    userName = "ArcticOwl-Dev";
    userEmail = "56565659+ArcticOwl-Dev@users.noreply.github.com";
  };
}
