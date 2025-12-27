{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.host;
in {
  options.host = {
    gui = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Whether to enable GUI components";
      };
    };

    hyprland.enable = mkOption {
      type = types.bool;
      default = config.host.gui.enable;
      description = "Whether to enable Hyprland";
    };
  };

  config = {
    programs.hyprland = {
      enable = cfg.hyprland.enable;
    };

    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/Hyprland";
          user = "r00t";
        };
      };
    };
  };
}
