# Brave browser configuration module
{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.brave ];

  # Create desktop entries for both Brave variants
  xdg.desktopEntries = {
    "brave-browser" = {
      name = "Brave";
      genericName = "Web Browser";
      exec = "${pkgs.brave}/bin/brave --profile-directory=Default %U";
      icon = "brave-browser";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
    "brave-browser-stream" = {
      name = "Brave Stream Profile";
      genericName = "Web Browser";
      exec = "${pkgs.brave}/bin/brave --profile-directory=\"Profile 2\" %U";
      icon = "brave-browser";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
  };


  # Add StartupWMClass to YouTube and Twitch desktop entries for waybar window matching
  # xdg.desktopEntries doesn't support startupWMClass, so we override them manually
  # Desktop entries go in ~/.local/share/applications/
  home.file.".local/share/applications/brave-youtube.desktop" = {
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=YouTube
      GenericName=Video Streaming
      Exec=${pkgs.brave}/bin/brave --app=https://www.youtube.com
      Icon=youtube
      Terminal=false
      Categories=Network;Video
      StartupWMClass=brave-www.youtube.com__-Default
    '';
  };
  home.file.".local/share/applications/brave-twitch.desktop" = {
    text = ''
      [Desktop Entry]
      Version=1.0
      Type=Application
      Name=Twitch
      GenericName=Video Streaming
      Exec=${pkgs.brave}/bin/brave --app=https://www.twitch.tv
      Icon=gnome-twitch
      Terminal=false
      Categories=Network;Video
      StartupWMClass=brave-www.twitch.tv__-Default
    '';
  };

  # Disable KWallet integration - Brave will use its own password storage instead
  # This prevents the "kde.kwallet is not installed" error
  # Since you're using Hyprland (not KDE), you don't need KWallet
  # Brave will use its built-in password manager instead
  home.sessionVariables = {
    # Prevent Brave/Chromium from trying to use KWallet
    # This merges with other sessionVariables from other modules
    # Tell Chromium-based browsers to use basic password storage
    CHROMIUM_FLAGS = "--password-store=basic";
  };
}

