{ config, lib, pkgs, ... }:
{

  # Steam configuration
  # solves laggy steam launcher - uses cpu instead of gpu rendering

  home.shellAliases = {
    steam = "steam -cef-disable-gpu -cef-disable-gpu-compositing";
  };

  # Or override the .desktop file so clicking the icon also works:
  xdg.desktopEntries.steam = {
    name = "Steam (No GPU)";
    exec = "steam -cef-disable-gpu -cef-disable-gpu-compositing %U";
    icon = "steam";
    terminal = false;
    categories = [ "Network" "FileTransfer" "Game" ];
  };
}

