# Main NixOS configuration
# This imports all system modules and is used by all hosts
{ inputs, lib, config, pkgs, ... }:
let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
in
{
  imports = [
    ./boot
    ./i18n
    ./sound
    ./desktop/plasma
    ./code-editor/cursor
    inputs.home-manager.nixosModules.home-manager
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

  # Nixpkgs configuration (inline, not a separate module)
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

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  system.stateVersion = "25.11";
}

