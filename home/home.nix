# Main Home Manager configuration
# This imports all home modules and is used by all hosts
{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./git
    ./nixpkgs
    ./browser/brave
    ./cursor
  ];

  # Enable all home modules by default
  homeSettings = {
    nixpkgs = {
      enable = true;
      allowUnfree = true;
      overlays = [
        inputs.self.overlays.additions
        inputs.self.overlays.modifications
        inputs.self.overlays.unstable-packages
      ];
    };
    git = {
      enable = true;
    };
  };

  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.05";
}

