# Main NixOS configuration
# This imports all system modules and is used by all hosts
{ inputs, lib, config, pkgs, ... }:
let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
in
{
  imports = [
    ./code-editor/cursor
  ];

  # Nix configuration (inline, not a separate module)
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      flake-registry = "";
      nix-path = config.nix.nixPath;
    };
    channel.enable = false;
    registry = lib.mapAttrs (_: flake: {inherit flake;}) flakeInputs;
    nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
  };

  # cachix cache configuration
  nix.settings = {
    extra-substituters = [
      "https://vicinae.cachix.org"                                                        # vicinae - application launcher
      ];
    extra-trusted-public-keys = [
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
  };

  # Adds .overlays edited packages to the nixpkgs set 
  nixpkgs = {
    overlays = [
      inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  environment.systemPackages = [ pkgs.nixfmt ];

  system.stateVersion = "25.11";
}

