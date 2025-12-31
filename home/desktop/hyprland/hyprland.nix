# Hyprland desktop configuration module
{ config, lib, pkgs, style, ... }:
let
  nerdFont = style.nerdFont;
in
{
  imports = [
    ./keybinds.nix
  ];
 

  home.packages = with pkgs; [  
    bibata-cursors          # Cursor theme
    adwaita-icon-theme      # Icon theme for applications (used by waybar wlr/taskbar)
    papirus-icon-theme      # Additional icon theme with more application icons (YouTube, Twitch, etc.)
    hicolor-icon-theme      # Fallback icon theme (contains Brave icon)
    nwg-dock-hyprland      # Dock for applications (used by waybar wlr/taskbar)
    ];
  
  # Configure foot terminal (simpler, more reliable on Wayland)
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "${nerdFont}:size=12";
        shell = "${pkgs.fish}/bin/fish";  # Explicitly use fish shell
      };
    };
  };

  # Configure satty (screenshot tool)
  programs.satty = {
    enable = true;
    settings = {
      general = {
        fullscreen = true;
        corner-roundness = 12;
        initial-tool = "brush";
        output-filename = "/tmp/test-%Y-%m-%d_%H:%M:%S.png";
      };
      color-palette = {
        palette = [ "#00ffff" "#a52a2a" "#dc143c" "#ff1493" "#ffd700" "#008000" ];
      };
    };
  };

  # Enable Hyprland Policykit Agent
  services.hyprpolkitagent.enable = true;
  

  wayland.windowManager.hyprland = {
    enable = true; # enable Hyprland
    
    settings = {

      # Monitor - Force 1920x1080 resolution
      # Empty monitor name (,) applies to all monitors
      monitor = ",5120x1440@239.76,auto,1"; 

      
      # Basic settings
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0;
      };
      
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
        resize_on_border = true;
        extend_border_grab_area = 10;
        hover_icon_on_border = true;

        snap = {
          enabled = true;
          window_gap = 10;
          monitor_gap = 10;
          border_overlap = false;
          respect_gaps = false;
        };
      };
      
      decoration = {
        rounding = 5;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

      };
      
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };
      
      dwindle = {
        pseudotile = true;
        preserve_split = true;
        smart_split = true;
        smart_resizing = true;
        single_window_aspect_ratio = "16 9";
      };
      
      misc = {
        force_default_wallpaper = -1;
      };

      # Window rules for better performance with video apps
      windowrulev2 = [
        # Optimize YouTube/Twitch app windows - disable animations and blur for better video performance
        "noanim,class:^(brave-.*)$"
        "noblur,class:^(brave-.*)$"
      ];

    };
  };
  

  
  # Configure pointer cursor for GTK/X11 apps
  # This also sets XCURSOR_THEME which hyprcursor uses
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;  # Needed for Xwayland apps
    size = 24;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    #name = "BreezeX-Dark";
    #package = pkgs.breeze-icons;
  };

  # Environment variables for Wayland support
  home.sessionVariables = {
    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Ensure Wayland is the default
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    # Papirus has more application icons including YouTube, Twitch, etc.
    GTK_ICON_THEME = "Papirus-Dark";
    # Set default browser 
    BROWSER = "firefox";
    # BROWSER = "brave";
    # Set desktop environment to prevent KDE/KWallet detection
    XDG_CURRENT_DESKTOP = "Hyprland";
    # Disable layer shell for vicinae (prevents closing when clicking outside)
    USE_LAYER_SHELL = "0";
  };
  
  # Set hyprcursor theme on Hyprland startup
  # hyprcursor will use XCURSOR_THEME automatically, but we set it explicitly for hyprcursor
  wayland.windowManager.hyprland.extraConfig = ''
    # Set cursor theme using hyprcursor (Bibata Modern Classic Right)
    exec-once = hyprctl setcursor "Bibata-Modern-Classic" 24
    
    # Start vicinae service on Hyprland startup
    exec-once = systemctl --user start vicinae

    # Start hyprpolkitagent service on Hyprland startup
    exec-once = systemctl --user start hyprpolkitagent
  '';
}
