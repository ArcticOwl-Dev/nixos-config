# Hyprland desktop configuration module
{ config, lib, pkgs, style, inputs, ... }:
let
  nerdFont = style.nerdFont;
in
{
  imports = [
    ./keybinds.nix
  ];
 

  home.packages = with pkgs; [  
    bibata-cursors          # Cursor theme
    papirus-icon-theme      # Additional icon theme with more application icons (YouTube, Twitch, etc.)
    hicolor-icon-theme      # Fallback icon theme (contains Brave icon)
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

  wayland.windowManager.hyprland.plugins = [
    pkgs.hyprlandPlugins.hyprscrolling
  ];




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
      
      cursor = {
        # Disable hardware cursors to prevent CPU rendering fallback during window movement
        no_hardware_cursors = true;
      };
      
      general = {
        gaps_in = 3;
        gaps_out = 5;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        layout = "scrolling";
        resize_on_border = true;
        extend_border_grab_area = 10;
        hover_icon_on_border = true;
        # Enable experimental tearing support for better performance (may cause visual artifacts)
        allow_tearing = true;

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
      
      render = {
        # Enable new render scheduling for better performance (experimental)
        # Disabled temporarily to test if it's causing the CPU rendering issue
        # new_render_scheduling = true;
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
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        # Performance optimizations
        vfr = true;  # Variable frame rate
        vrr = 2;  # Variable refresh rate (0=off, 1=on, 2=fullscreen only)
      };

      # Window rules for better performance with video apps and games
      windowrulev2 = [
        # Optimize YouTube/Twitch app windows - disable animations and blur for better video performance
        "noanim,class:^(brave-.*)$"
        "noblur,class:^(brave-.*)$"
        
        # Optimize Steam and games - disable animations, blur, and enable performance optimizations
        "noanim,class:^(steam)$"
        "noblur,class:^(steam)$"
        "noanim,class:^(steam_app_.*)$"
        "noblur,class:^(steam_app_.*)$"
        "immediate,class:^(steam_app_.*)$"  # Immediate rendering for games
        "float,class:^(steam_app_.*)$"  # Keep games floating for better performance
        "opaque,class:^(steam_app_.*)$"  # Disable transparency for better performance
        "noborder,class:^(steam_app_.*)$"  # Remove borders for better performance
        "suppressevent maximize,class:^(steam_app_.*)$"  # Suppress maximize events for games
        "suppressevent fullscreen,class:^(steam_app_.*)$"  # Suppress fullscreen events
        
        # Optimize gamescope (Steam's compositor)
        "noanim,class:^(gamescope)$"
        "noblur,class:^(gamescope)$"
        "immediate,class:^(gamescope)$"
        "float,class:^(gamescope)$"  # Keep gamescope floating
        "opaque,class:^(gamescope)$"  # Disable transparency
        "noborder,class:^(gamescope)$"  # Remove borders
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
    # Qt/KDE theming - use KDE platform theme with Breeze dark
    QT_QPA_PLATFORMTHEME = "kde";
    QT_STYLE_OVERRIDE = "breeze";
    # Setting Global Icon Theme for GTK, Qt Apps
    GTK_ICON_THEME = "Papirus-Dark";
    QS_ICON_THEME = "Papirus-Dark";
    # Set default browser for terminal/CLI tools
    BROWSER = "brave";
    # Set desktop environment to prevent KDE/KWallet detection
    XDG_CURRENT_DESKTOP = "Hyprland";
    # Disable layer shell for vicinae (prevents closing when clicking outside)
    USE_LAYER_SHELL = "0";
    # Force GPU acceleration for XWayland applications (prevents CPU fallback)
    LIBGL_ALWAYS_SOFTWARE = "0";  # Force hardware acceleration
    __GLX_VENDOR_LIBRARY_NAME = "mesa";  # Use Mesa for OpenGL
    GALLIUM_DRIVER = "radeonsi";  # Use AMD GPU driver
    # Disable hardware cursors to prevent rendering issues during window movement
    WLR_NO_HARDWARE_CURSORS = "1";
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
    
    # Workaround for XWayland window movement CPU rendering issue
    # Force immediate rendering for all XWayland windows to prevent CPU fallback
    windowrulev2 = immediate, xwayland:1
    
    # Hyprscrolling plugin configuration
    plugin {
      hyprscrolling {
        column_width = 0.33
        fullscreen_on_one_column = false
      }
    }
  '';
}
