# Hyprland desktop configuration module
{ config, lib, pkgs, inputs, ... }:
{

  programs.hyprland = {
    enable = true;                                        # enable Hyprland
    withUWSM = true;                                      # enable Universal Wayland Session Manager
    xwayland.enable = true;                               # enable Xwayland (for x11 apps in wayland)
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;     # xdph none git
  };

  programs = {
    dconf.enable = true;                                  # enable dconf (gnome settings manager)
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




  # XDG Desktop Portal for KDE apps (in addition to Hyprland portal)
  xdg.portal = {
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
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