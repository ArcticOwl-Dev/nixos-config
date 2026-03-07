# SDDM display manager theming
{ config, lib, pkgs, ... }:

let
  # Wallpaper path as store path so SDDM greeter can load it at runtime
  tf2Wallpaper = ../../../assets/wallpaper/tf2.png;
  # Local theme (pkgs.local.sddm-astronaut) with black_hole + custom config
  sddm-astronaut-black-hole = pkgs.local.sddm-astronaut.override {
    embeddedTheme = "black_hole";
    themeConfig = {
      background = "${tf2Wallpaper}";
      ScreenWidth = 5120;
      ScreenHeight = 1440;
      PartialBlur = true;
      BlurMax = 48;
      ScreenPadding = 0;
      LoginFormWidth = 25;
      PasswordFieldWidth = 350;
      UsernameFieldWidth = 350;
      LoginButtonWidth = 350;
      UsernameFieldAlignment = "left";
      PasswordFieldAlignment = "left";
      DateFormat = "dddd d.MMM";
      FormBackgroundColor = "#5A5A5A";
    };
  };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "sddm-astronaut-theme";

    extraPackages = [
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtvirtualkeyboard
      sddm-astronaut-black-hole
    ];
  };

  environment.systemPackages = [
    sddm-astronaut-black-hole
  ];
}
