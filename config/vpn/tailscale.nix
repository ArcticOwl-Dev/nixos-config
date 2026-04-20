# Tailscale VPN
{ config, ... }:

{
  services.tailscale = {
    enable = true;
    openFirewall = true;
    #authKeyFile = config.sops.secrets.tailscale-auth-key.path;
  };
}
