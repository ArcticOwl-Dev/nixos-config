# Main Home Manager configuration
# This imports all home modules and is used by all hosts
{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    ./git
    ./cli
    ./desktop/hyprland.nix
    ./desktop/wlogout.nix
    ./desktop/hyprlock.nix
    ./desktop/wlockout.nix
    ./appLauncher/walker.nix
  ];


  # Enable home-manager
  programs.home-manager.enable = true;

  # Configure default shell (bash is default on NixOS, but let's be explicit)
  programs.bash.enable = true;

  # Add ~/.local/bin to PATH for custom scripts
  home.sessionPath = [ "$HOME/.local/bin" ];

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "25.11";
}
