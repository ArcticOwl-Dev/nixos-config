# Home Manager Nixpkgs configuration module
{ config, lib, pkgs, ... }:

let
  cfg = config.homeSettings.nixpkgs;
in
{
  options = {
    homeSettings.nixpkgs = {
      enable = lib.mkEnableOption "Enable Home Manager Nixpkgs configuration";
      allowUnfree = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Allow unfree packages";
      };
      overlays = lib.mkOption {
        type = lib.types.listOf lib.types.unspecified;
        default = [];
        description = "Nixpkgs overlays";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    nixpkgs = {
      overlays = cfg.overlays;
      config = {
        allowUnfree = cfg.allowUnfree;
      };
    };
  };
}

