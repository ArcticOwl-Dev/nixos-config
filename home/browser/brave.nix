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

  # Create desktop entries for Brave browser and PWA apps
  # Using xdg.desktopEntries ensures proper StartupWMClass for waybar window matching
  xdg.desktopEntries = {
    "brave-browser" = {
      name = "Brave";
      genericName = "Web Browser";
      exec = "${braveWithFlags}/bin/brave %U";
      icon = "brave-browser";
      terminal = false;
      categories = [ "Network" "WebBrowser" ];
    };
    "brave-youtube" = {
      name = "YouTube";
      genericName = "Video Streaming";
      exec = "${braveWithFlags}/bin/brave --app=https://www.youtube.com";
      icon = "youtube";
      terminal = false;
      categories = [ "Network" "Video" ];
      startupWMClass = "brave-www.youtube.com__-Default";
    };
    "brave-twitch" = {
      name = "Twitch";
      genericName = "Video Streaming";
      exec = "${braveWithFlags}/bin/brave --app=https://www.twitch.tv";
      icon = "gnome-twitch";
      terminal = false;
      categories = [ "Network" "Video" ];
      startupWMClass = "brave-www.twitch.tv__-Default";
    };
  };

  # Disable KWallet integration - Brave will use its own password storage instead
  # This prevents the "kde.kwallet is not installed" error
  # Since you're using Hyprland (not KDE), you don't need KWallet
  # Brave will use its built-in password manager instead
  home.sessionVariables = {
    # Prevent Brave/Chromium from trying to use KWallet
    # This merges with other sessionVariables from other modules
    KDE_SESSION_VERSION = "";
    KDE_FULL_SESSION = "";
    # Tell Chromium-based browsers to use basic password storage
    CHROMIUM_FLAGS = "--password-store=basic";
    # Set desktop environment to prevent KDE detection
    XDG_CURRENT_DESKTOP = "Hyprland";
  };
}

