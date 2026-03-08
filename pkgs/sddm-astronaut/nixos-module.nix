# NixOS module for sddm-astronaut-theme.
# Set package + optional embeddedTheme/themeConfig; the module overrides the package
# and points SDDM at the theme in the Nix store.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  themeName = "sddm-astronaut-theme";

  cfg = config.services.displayManager.sddm.astronautTheme;

  themePackage = cfg.package.override {
    embeddedTheme = cfg.embeddedTheme;
    themeConfig = if cfg.themeConfig != { } then cfg.themeConfig else null;
  };
in
{
  options.services.displayManager.sddm.astronautTheme = {
    package = lib.mkOption {
      type = lib.types.nullOr lib.types.package;
      default = null;
      example = lib.literalExpression "pkgs.local.sddm-astronaut";
      description = ''
        The sddm-astronaut package to use (e.g. pkgs.local.sddm-astronaut).
        When set, the theme is enabled and overridden with embeddedTheme and themeConfig.
      '';
    };

    embeddedTheme = lib.mkOption {
      type = lib.types.str;
      default = "astronaut";
      example = "black_hole";
      description = ''
        Theme variant (e.g. astronaut, black_hole, cyberpunk). Must match a
        subtheme in the package's Themes/ directory.
      '';
    };

    themeConfig = lib.mkOption {
      type = lib.types.attrsOf (lib.types.oneOf [
        lib.types.str
        lib.types.int
        lib.types.float
        lib.types.bool
        lib.types.path
      ]);
      default = { };
      example = {
        background = "/path/to/wallpaper.png";
        ScreenWidth = 1920;
        Blur = 2.0;
      };
      description = ''
        Key-value config for the theme's [General] section, written to
        Themes/<embeddedTheme>.conf.user. Options depend on the theme variant.
      '';
    };
  };

  config = lib.mkIf (config.services.displayManager.sddm.enable && cfg.package != null) {
    services.displayManager.sddm = {
      # Full store path so SDDM loads the theme directly (avoids ThemeDir lookup issues).
      theme = "${themePackage}/share/sddm/themes/${themeName}";
      # ThemeDir so SDDM can also find it by name.
      settings.Theme.ThemeDir = "${themePackage}/share/sddm/themes,/run/current-system/sw/share/sddm/themes";
      extraPackages = lib.mkAfter [
        themePackage
        pkgs.kdePackages.qtmultimedia
        pkgs.kdePackages.qtsvg
        pkgs.kdePackages.qtvirtualkeyboard
      ];
    };

    environment.systemPackages = [ themePackage ];
  };
}
