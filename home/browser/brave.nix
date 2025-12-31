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
  
  brave = pkgs.makeDesktopItem {
    name = "brave-browser";
    desktopName = "Brave";
    genericName = "Web Browser";
    exec = "${braveWithFlags}/bin/brave %U";
    # Use icon name - hicolor-icon-theme should have it
    icon = "brave-browser";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
    mimeTypes = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
  };
  
  braveYouTube = pkgs.writeTextFile {
    name = "brave-youtube.desktop";
    destination = "/share/applications/brave-youtube.desktop";
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
  
  braveTwitch = pkgs.writeTextFile {
    name = "brave-twitch.desktop";
    destination = "/share/applications/brave-twitch.desktop";
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
in
{
  # Install wrapped Brave that disables KWallet
  # This wrapper handles all the necessary flags and environment variables
  home.packages = [ braveWithFlags brave braveYouTube braveTwitch ];

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

