{ config, lib, pkgs, inputs, ... }:
{
  imports = [
    inputs.dms.homeModules.dankMaterialShell.default
  ];

  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = false;
      restartIfChanged = false;
    };

    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableClipboard = true;            # Clipboard history manager
    enableVPN = true;                  # VPN management widget
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
  };

  # Configure bar settings
  # DMS uses QML configuration files in ~/.config/quickshell/dms/
  # You can configure via:
  # 1. dms CLI: dms config set position bottom
  # 2. Edit QML files directly in ~/.config/quickshell/dms/
  # 3. Use the settings attribute if the Home Manager module supports it
  #
  # Common bar settings:
  # - position: "top" or "bottom"
  # - height: number (pixels)
  # - spacing: number (pixels)
  # - theme: "dark" or "light"
  #
  # Note: The exact config structure depends on the Home Manager module.
  # If settings don't work, check ~/.config/quickshell/dms/ after first run
  # and configure via xdg.configFile or use the dms CLI tool
  # Add your dankLinuxBar configuration here
}

