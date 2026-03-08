# SDDM display manager theming
# Theme and .conf are configured via the sddm-astronaut NixOS module.
{ config, lib, pkgs, ... }:

{
  imports = [ ../../../pkgs/sddm-astronaut/nixos-module.nix ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;

    astronautTheme = {
      package = pkgs.local.sddm-astronaut;
      embeddedTheme = "black_hole";
      themeConfig = {
        background = "${../../../assets/wallpaper/tf2.png}";
        ScreenWidth = 5120;
        ScreenHeight = 1440;
        PartialBlur = true;
        BlurMax = 40;
        Blur = 2.0;
        ScreenPadding = 0;
        LoginFormWidth = 25;
        PasswordFieldWidth = 350;
        UsernameFieldWidth = 350;
        LoginButtonWidth = 350;
        UsernameFieldAlignment = "left";
        PasswordFieldAlignment = "left";
        DateFormat = "dddd d. MMM";
        FormBackgroundColor = "#5A5A5A";
        Debug = true;
      };
    };
  };
}
