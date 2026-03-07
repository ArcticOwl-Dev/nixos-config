# Tailscale VPN
{ ... }:

{
  services.tailscale = {
    enable = true;
    openFirewall = true;
  };

  
}
