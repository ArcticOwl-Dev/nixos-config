# Brave browser configuration module
{ config, lib, pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    # Disable KWallet - use basic password storage instead
    extraFlags = [
      "--password-store=basic"
      "--disable-features=UseChromeOSDirectVideoDecoder"
    ];
  };

  # Disable KWallet integration - Brave will use its own password storage instead
  # This prevents the "kde.kwallet is not installed" error
  # Since you're using Hyprland (not KDE), you don't need KWallet
  # Brave will use its built-in password manager instead
  home.sessionVariables = {
    # Prevent Brave/Chromium from trying to use KWallet
    # This merges with other sessionVariables from other modules
    KDE_SESSION_VERSION = "";
    # Tell Chromium-based browsers to use basic password storage
    CHROMIUM_FLAGS = "--password-store=basic";
    # Explicitly disable KWallet
    KDE_FULL_SESSION = "";
  };
}

