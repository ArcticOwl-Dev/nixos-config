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

  




  environment.systemPackages = with pkgs; [
    kitty # required for the default Hyprland config

    # Hyprland Stuff
    hypridle                                              # hypridle (idle detection)
    hyprpolkitagent                                       # hyprpolkitagent (polkit agent)
    pyprland                                              # pyprland (python bindings for hyprland)
    
    #uwsm
    hyprlang                                              # hyprlang (language support)
    hyprshot                                              # hyprshot (screenshot tool)
    hyprcursor                                            # hyprcursor (cursor support)
    mesa                                                  # mesa (graphics driver)
    nwg-displays                                          # nwg-displays (display manager)
    nwg-look                                              # nwg-look (theme manager)
    waypaper                                              # waypaper (wallpaper manager)
    waybar                                                # waybar (taskbar)
    hyprland-qt-support                                   # hyprland-qt-support (qt support)

    wl-clipboard                                          # wl-clipboard (clipboard manager)
    wlogout                                               # wlogout (logout menu)
    wdisplays                                             # wdisplays (display manager)
    swww                                                  # swww (wallpaper manager)
    swappy                                                # swappy (screenshot tool)
    slurp                                                 # slurp (selection tool)
    grim                                                  # grim (screenshot tool)
    grimblast                                             # grimblast (screenshot tool)

    #rofi                                                  # rofi (application launcher)

    pavucontrol                                           # pavucontrol (pulseaudio control)
    playerctl                                             # playerctl (media player controller)
    pamixer                                               # pamixer (pulseaudio mixer)

    libappindicator                                       # libappindicator (app indicator)
    libnotify                                             # libnotify (notification manager)
  ];

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}