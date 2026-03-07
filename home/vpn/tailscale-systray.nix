# Official Tailscale systray (system tray UI for status, exit node, etc.)
{ config, lib, pkgs, ... }:

{
  services.tailscale-systray = {
    enable = true;
  };
}
