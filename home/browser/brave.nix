# Brave browser configuration module
{ config, lib, pkgs, ... }:
let
  braveWithFlags = pkgs.writeShellScriptBin "brave" ''
    export KDE_SESSION_VERSION=""
    export KDE_FULL_SESSION=""
    export XDG_CURRENT_DESKTOP="Hyprland"
    export CHROMIUM_FLAGS="--password-store=basic"
    exec ${pkgs.brave}/bin/brave \
      --password-store=basic \
      --enable-features=UseOzonePlatform \
      --ozone-platform=wayland \
      --enable-gpu \
      --enable-gpu-rasterization \
      --enable-zero-copy \
      --use-gl=egl \
      --enable-features=VaapiVideoDecoder \
      --disable-gpu-vsync \
      "$@"
  '';
  
in
{
  # Install wrapped Brave that disables KWallet
  # This wrapper handles all the necessary flags and environment variables
  # braveWithFlags needs to be in packages so it's available in PATH
  home.packages = [ braveWithFlags ];

  # Create desktop entries for Brave browser
  xdg.desktopEntries = {
    "brave-browser" = {
      name = "Brave";
      genericName = "Web Browser";
      exec = "${braveWithFlags}/bin/brave %U";
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
      Exec=${braveWithFlags}/bin/brave --app=https://www.youtube.com
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
      Exec=${braveWithFlags}/bin/brave --app=https://www.twitch.tv
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
    # Set desktop environment to prevent KDE detection
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}

