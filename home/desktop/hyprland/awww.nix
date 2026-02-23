{
  config,
  lib,
  pkgs,
  ...
}:
{
  # awww wallpaper daemon setup (formerly swww)
  # Note: Package and binaries are still named swww in nixpkgs, but the project is now called awww
  home.packages = with pkgs; [
    swww  # Package name in nixpkgs (binaries are still swww and swww-daemon)
  ];

  # Systemd user service to start awww daemon
  systemd.user.services.awww = {
    Unit = {
      Description = "awww wallpaper daemon (swww)";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      # Binaries are still named swww-daemon in the package
      ExecStart = "${pkgs.swww}/bin/swww-daemon";
      Restart = "on-failure";
      RestartSec = 3;
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  # Add awww commands to Hyprland startup
  # This will be merged with the existing extraConfig in hyprland.nix
  wayland.windowManager.hyprland.extraConfig = ''
    # Start awww daemon and set wallpaper (binaries still named swww)
    exec-once = swww-daemon
    exec-once = sleep 1 && swww img ${config.home.homeDirectory}/.local/share/wallpapers/tf2.png --transition-type wipe --transition-duration 1
  '';
}

