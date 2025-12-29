# Remote Touchpad configuration
{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/remote-touchpad
  ];

  # Remote Touchpad - built from source with Go
  services.remote-touchpad = {
    enable = true;
    user = "r00t";
    autoStart = true;  # Set to true if you want it to start automatically
    port = 40999;       # Default port
    keymap = "de";      # German keyboard layout
    secret = "your-secret-password-here";  # Set a secret to avoid QR code scanning
  };
}

