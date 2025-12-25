{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  # Ensure vicinae binary is in PATH
  home.packages = [ 
    inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.vicinae
  ];

  services.vicinae = {
    enable = true;
    package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.vicinae;
        systemd = {
            enable = true;
            autoStart = true; # default: false
            environment = {
            USE_LAYER_SHELL = 1;
            };
        };
        settings = {
            close_on_focus_loss = true;
            consider_preedit = true;
            pop_to_root_on_close = true;
            favicon_service = "twenty";
            search_files_in_root = true;
            font = {
            normal = {
                size = 12;
                normal = "Maple Nerd Font";
            };
            };
            theme = {
            light = {
                name = "vicinae-light";
                icon_theme = "default";
            };
            dark = {
                name = "vicinae-dark";
                icon_theme = "default";
            };
            };
            launcher_window = {
            opacity = 0.98;
            };
        };
        extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
            nix
            power-profile
            hypr-keybinds
            # Extension names can be found in the link below, it's just the folder names
        ];
    };
}