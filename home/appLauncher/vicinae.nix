{ config, lib, pkgs, style, inputs, ... }:
let
  nerdFont = style.nerdFont;
in
{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
        systemd = {
            enable = true;
            autoStart = true; # default: false
            environment = {
            USE_LAYER_SHELL = 1;
            };
        };
        settings = {
            closeOnFocusLoss = true;
            considerPreedit = true;
            pop_to_root_on_close = true;
            favicon_service = "twenty";
            search_files_in_root = true;
            font = {
            normal = {
                size = 12;
                normal = "${nerdFont}";
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
            opacity = 0.95;
            };
        };
          extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
                bluetooth
                nix
                power-profile
                hypr-keybinds
                process-manager
                pulseaudio

                # Extension names can be found in the link below, it's just the folder names
            ];
    };
}