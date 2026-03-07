# Brave browser configuration module
{ config, lib, pkgs, ... }:

let
  braveWithArgs = pkgs.brave.override {
    commandLineArgs = [
      "--password-store=basic"
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--disable-gpu-memory-buffer-video-frames" # Reduces those GLib errors in your logs
      "--enable-features=OverlayScrollbar"        # Autohides scrollbars
      "--enable-features=FluentOverlayScrollbars" # Autohides scrollbars
    ];
  };
in {

  home.packages = [ braveWithArgs ];

  # Create desktop entries for both Brave variants (use overridden Brave so --password-store=basic etc. apply)
  xdg.desktopEntries = {
    "brave-browser" = {
      name = "Brave";
      genericName = "Web Browser";
      exec = "${braveWithArgs}/bin/brave --profile-directory=Default %U";
      icon = "brave-browser";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
    "brave-browser-stream" = {
      name = "Brave Stream Profile";
      genericName = "Web Browser";
      exec = "${braveWithArgs}/bin/brave --profile-directory=\"Profile 2\" %U";
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
      Exec=${braveWithArgs}/bin/brave --app=https://www.youtube.com
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
      Exec=${braveWithArgs}/bin/brave --app=https://www.twitch.tv
      Icon=gnome-twitch
      Terminal=false
      Categories=Network;Video
      StartupWMClass=brave-www.twitch.tv__-Default
    '';
  };
}

