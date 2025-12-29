{ config, pkgs, lib, style, ... }:
let
  nerdFont = style.nerdFont;
  waybarSettings = {
      # General
      layer = "bottom";              
      position = "bottom";
      height = 30;
      spacing = 4;
      mode = "dock";
      start_hidden = false;
      exclusive = true;
      fixed-center = true;
      passthrough = false;
      reload_style_on 


      tray = { spacing = 10; };
      modules-center = [ "sway/window" ];
      modules-left = [ "hyprland/workspaces"];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        "temperature"
        "clock"
        "tray"
      ];

      # Modules
      "hyprland/workspaces": {
        "format": "<sub>{icon}</sub>\n{windows}",
        "format-window-separator": "\n",
        "window-rewrite-default": "",
        "window-rewrite": {
          "title<.*youtube.*>": "", // Windows whose titles contain "youtube"
          "class<firefox>": "", // Windows whose classes are "firefox"
          "class<firefox> title<.*github.*>": "", // Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
          "foot": "", // Windows that contain "foot" in either class or title. For optimization reasons, it will only match against a title if at least one other window explicitly matches against a title.
          "code": "󰨞",
        }
      };
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [ "" "" "" "" "" ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = { format = "{}% "; };
      network = {
        interval = 1;
        format-alt = "{ifname}: {ipaddr}/{cidr}";
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [ "" "" "" ];
          handsfree = "";
          headphones = "";
          headset = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
        on-click = "pavucontrol";
      };
      "sway/mode" = { format = ''<span style="italic">{}</span>''; };
      temperature = {
        critical-threshold = 80;
        format = "{temperatureC}°C {icon}";
        format-icons = [ "" "" "" ];
      };
    };
  waybarStyle = ''
    ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}

    window#waybar {
      background: black;
      border-bottom: none;
    }
  '';
in
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = waybarStyle;
    settings = [ waybarSettings ];
  };

  # Force overwrite existing waybar config files
  # This ensures Home Manager overwrites existing files instead of failing
  xdg.configFile."waybar/config" = {
    force = true;
    text = builtins.toJSON waybarSettings;
  };
  xdg.configFile."waybar/style.css" = {
    force = true;
    text = waybarStyle;
  };

  # Create waybar toggle script
  home.file.".config/waybar/toggle.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      # Toggle waybar visibility
      
      if systemctl --user is-active --quiet waybar; then
        systemctl --user stop waybar
      else
        systemctl --user start waybar
      fi
    '';
  };
}