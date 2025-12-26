# Hyprland desktop configuration module
{ config, lib, pkgs, style, ... }:
let
  nerdFont = style.nerdFont;
imports = [
  ./keybinds.nix
];
  in
{
  # Install wofi (application launcher)
  home.packages = with pkgs; [ 
    wofi 
    bibata-cursors
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
      };
      
      decoration = {
        rounding = 3;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };

      };
      
      animations = {
        enabled = "yes";
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
        pseudotile = "yes";
        preserve_split = "yes";
      };
      
      misc = {
        force_default_wallpaper = -1;
      };
    };
  };
  

  
  # Configure pointer cursor for GTK/X11 apps
  # This also sets XCURSOR_THEME which hyprcursor uses
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;  # Needed for Xwayland apps
    name = "Bibata-Modern-Classic";
    size = 24;
    package = pkgs.bibata-cursors;
  };

  # Environment variables for Wayland support
  home.sessionVariables = {
    # Hint Electron apps to use Wayland
    NIXOS_OZONE_WL = "1";
    # Ensure Wayland is the default
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    # Set default browser 
    BROWSER = "firefox";
    # BROWSER = "brave";
    # Set desktop environment to prevent KDE/KWallet detection
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
  
  # Set hyprcursor theme on Hyprland startup
  # hyprcursor will use XCURSOR_THEME automatically, but we set it explicitly for hyprcursor
  wayland.windowManager.hyprland.extraConfig = ''
    # Set cursor theme using hyprcursor (Bibata Modern Classic Right)
    exec-once = hyprctl setcursor "Bibata-Modern-Classic" 24
    
    # Start vicinae service on Hyprland startup
    exec-once = systemctl --user start vicinae
  '';
}