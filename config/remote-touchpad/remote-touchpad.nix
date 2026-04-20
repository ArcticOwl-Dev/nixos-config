# Remote Touchpad configuration
{ config, lib, pkgs, ... }:

{
  imports = [
    ../../modules/remote-touchpad
  ];

  # Remote Touchpad — flake package + optional tsnet (see modules/remote-touchpad)
  services.remote-touchpad = {
    enable = true;
    user = "r00t";
    autoStart = true;
    port = 40999;
    keymap = "de";
    # Optional HTTP shared secret (or add to sops later). null = QR pairing.
    secret = "my-secret-password";
    # tsnet: stable hostname on your tailnet; auth key from sops (same as system Tailscale can use).
    tailscaleHostname = "remote-touchpad";
    tailscaleAuthKeyFile = config.sops.secrets.tailscale-auth-key.path;
  };
}

