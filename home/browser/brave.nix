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
      --disable-features=UseChromeOSDirectVideoDecoder \
      "$@"
  '';
in
{
  # Install wrapped Brave that disables KWallet
  # This wrapper handles all the necessary flags and environment variables
  home.packages = [ braveWithFlags ];

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

