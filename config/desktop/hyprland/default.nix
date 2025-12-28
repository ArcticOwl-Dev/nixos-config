# Hyprland desktop configuration module
{ config, lib, pkgs, ... }:
{

  programs.hyprland = {
    enable = true;                                        # enable Hyprland
    withUWSM = true;                                      # enable Universal Wayland Session Manager
    xwayland.enable = true;                               # enable Xwayland (for x11 apps in wayland)
    portalPackage = pkgs.xdg-desktop-portal-hyprland;     # xdph none git
  };

  programs = {
    waybar.enable = true;                                 # enable waybar (taskbar)
    hyprlock.enable = true;                               # enable hyprlock (lock screen)
    dconf.enable = true;                                  # enable dconf (gnome settings manager)
    seahorse.enable = true;                               # enable seahorse (password manager)
    fuse.userAllowOther = true;                           # enable fuse (file system manager)
    mtr.enable = true;                                    # enable mtr (network monitor)
    gnupg.agent = {
      enable = true;                                      # enable gnupg (secret key management)
      enableSSHSupport = true;                            # enable ssh support
    };
  };

  # Greetd auto-login configuration
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "r00t";
      };
    };
  };




  environment.systemPackages = with pkgs; [
    # System-wide packages (needed for system services or multiple users)
    mesa                                                  # mesa (graphics driver - system-wide)
    hyprpolkitagent                                       # hyprpolkitagent (polkit agent - system-wide)
    hyprland-qt-support                                   # hyprland-qt-support (qt support - system-wide)
    libappindicator                                       # libappindicator (app indicator - system-wide library)
    libnotify                                             # libnotify (notification manager - system-wide library)
    
    # Note: User-specific packages (waybar, hyprlock, hypridle, swww, grim, slurp, etc.)
    # are configured in Home Manager and don't need to be in systemPackages
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}