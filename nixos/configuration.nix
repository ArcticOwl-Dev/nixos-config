# Main NixOS configuration
# This imports all system modules and is used by all hosts
{ inputs, lib, config, pkgs, ... }:
let
  flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
in
{
  imports = [
    ./i18n
    ./sound
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

  # Walker cachix cache configuration
  nix.settings = {
    extra-substituters = [
      "https://walker.cachix.org"                                                         # walker - application launcher
      "https://walker-git.cachix.org"
      "https://vicinae.cachix.org"                                                        # vicinae - application launcher
      ];
    extra-trusted-public-keys = [
      "walker.cachix.org-1:fG8q+uAaMqhsMxWjwvk0IMb4mFPFLqHjuvfwQxE4oJM=" 
      "walker-git.cachix.org-1:vmC0ocfPWh0S/vRAQGtChuiZBTAe4wiKDeyyXM0/7pM="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
      ];
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

  # Add home-manager command to system packages
  environment.systemPackages = [
    inputs.home-manager.packages.${config.nixpkgs.hostPlatform.system}.home-manager
  ];

  # Home Manager configuration
  home-manager = {
    extraSpecialArgs = { 
      inherit inputs;
      # Note: style variables should be defined in host-specific configuration
      # For stardust, it's defined in hosts/stardust/configuration.nix
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    # Backup file extension for home-manager files (default is "backup")
    backupFileExtension = "old";
  };

  system.stateVersion = "25.11";
}

