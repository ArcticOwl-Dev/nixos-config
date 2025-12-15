# Git configuration module
{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.git;
in
{
  options = {
    homeSettings.git = {
      enable = lib.mkEnableOption "Enable Git configuration";
      userName = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "ArcticOwl-Dev";
      };
      userEmail = lib.mkOption {
        type = lib.types.nullOr lib.types.str;
        default = null;
        description = "56565659+ArcticOwl-Dev@users.noreply.github.com";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.userName;
      userEmail = cfg.userEmail;
    };
  };
}

