{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  # Ensure walker binary is in PATH
  home.packages = [ 
    inputs.walker.packages.${pkgs.stdenv.hostPlatform.system}.walker
  ];

  programs.walker = {
    enable = true;
    runAsService = true;

    # Configuration options
  config = {
    theme = "default";
    placeholders.default = {
      input = "Search";
      list = "No Results";
    };
    providers.prefixes = [
      { provider = "websearch"; prefix = "+"; }
      { provider = "providerlist"; prefix = "_"; }
    ];
    keybinds.quick_activate = ["F1" "F2" "F3"];
  };
  };
}