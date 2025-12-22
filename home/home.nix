# Main Home Manager configuration
# This imports all home modules and is used by all hosts
{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./git
  ];


  # Enable home-manager
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
