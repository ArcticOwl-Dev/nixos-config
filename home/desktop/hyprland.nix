# Hyprland desktop configuration module
{ config, lib, pkgs, style, ... }:
let
  nerdFont = style.nerdFont;
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
      monitor = ",1920x1080@60,auto,1"; 


      # Main modifier key (Super/Windows key)
      "$mainMod" = "SUPER";
      
      # Keybindings
      bind = [
        # Launch appLauncher vicinae (Super + Space)
        "$mainMod, SPACE, exec, vicinae toggle"

        # Launch terminal (Super + Q) - foot (more reliable on Wayland)
        "$mainMod, Q, exec, foot"
        
        # Test keybinding (Super + T) - opens a notification to test if keybindings work
        "$mainMod, T, exec, notify-send 'Keybinding works!' 'If you see this, keybindings are working'"
        
        # Debug: Test if commands work (Super + Shift + T)
        "$mainMod SHIFT, T, exec, foot -e sh -c 'echo Testing; read'"
        
        # Close window (Super + Shift + Q)
        "$mainMod SHIFT, Q, killactive"
        
        # Exit Hyprland (Super + M)
        "$mainMod, M, exit"
        
        # Alternative: Exit Hyprland (Super + Shift + E)
        "$mainMod SHIFT, E, exit"
        
        # Launch walker (Super + R)
        # If walker service is running, use the socket for faster launch
        "$mainMod, R, exec, walker"
        # Alternative if direct command doesn't work:
        # "$mainMod, R, exec, ${pkgs.walker}/bin/walker"
        
        # Launch Brave browser (Super + B)
        "$mainMod, B, exec, brave"
        
        # Move focus with arrow keys (Super + Arrow)
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"
        
        # Switch workspaces (Super + 1-9)
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        
        # Move window to workspace (Super + Shift + 1-9)
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
      ];
      
      # Basic settings
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0;
      };
      
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "dwindle";
      };
      
      decoration = {
        rounding = 10;
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