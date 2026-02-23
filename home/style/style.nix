{config, lib, pkgs, ...}:
{
  home.packages = with pkgs; [
      papirus-icon-theme      # Additional icon theme with more application icons (YouTube, Twitch, etc.)
      nerd-fonts.noto
    ];
}