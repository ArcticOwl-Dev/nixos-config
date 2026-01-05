{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  # Ensure icon theme packages are available for DMS
  home.packages = with pkgs; [
    papirus-icon-theme
    hicolor-icon-theme
  ];

  # Configure GTK icon theme for DMS to display application icons
  gtk.iconTheme = {
    name = "Papirus-Dark";
    package = pkgs.papirus-icon-theme;
  };

  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = false;
      restartIfChanged = false;
    };

    default.settings = {
      theme = "dark";
      
    };

    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)

    plugins = {
      # nix-monitor = {
      #   src = pkgs.fetchFromGitHub {
      #     owner = "antonjah";
      #     repo = "nix-monitor";
      #     rev = "v1.0.3";
      #     sha256 = "sha256-biRc7ESKzPK5Ueus1xjVT8OXCHar3+Qi+Osv/++A+Ls=";
      #   };
      # };
      # dms-wallpaperengine = {
      #   src = pkgs.fetchFromGitHub {
      #     owner = "sgtaziz";
      #     repo = "dms-wallpaperengine";
      #     rev = "v1.0.0";
      #     sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";  # TODO: Get correct hash
      #   };
      #};
      DockerManager = {
        src = pkgs.fetchFromGitHub {
          owner = "LuckShiba";
          repo = "DmsDockerManager";
          rev = "v1.2.0";
          sha256 = "sha256-VoJCaygWnKpv0s0pqTOmzZnPM922qPDMHk4EPcgVnaU=";
        };
      };
    };
  };

  # Create a wrapper script to start DMS with proper icon theme environment variables
  # QS_ICON_THEME is used by quickshell (which DMS is based on) to find application icons
  home.file.".local/bin/dms-start.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      export QS_ICON_THEME="Papirus-Dark"
      export GTK_ICON_THEME="Papirus-Dark"
      export DMS_DISABLE_MATUGEN="1"
      # XDG_DATA_DIRS with all necessary paths for desktop file discovery
      export XDG_DATA_DIRS="${config.home.profileDirectory}/share:/etc/profiles/per-user/${config.home.username}/share:/run/current-system/sw/share:${config.home.homeDirectory}/.local/share:/nix/var/nix/profiles/default/share"
      exec ${config.home.profileDirectory}/bin/dms run "$@"
    '';
  };

  # Start DMS from Hyprland with the wrapper script
  wayland.windowManager.hyprland.extraConfig = ''
    exec-once = ${config.home.homeDirectory}/.local/bin/dms-start.sh
  '';
}

