# Custom sddm-astronaut theme from your fork (ArcticOwl-Dev).
# Based on official nixpkgs; supports embeddedTheme and themeConfig overrides.
{
  pkgs,
  lib,
  stdenvNoCC,
  themeConfig ? null,
  embeddedTheme ? "astronaut",
}:
stdenvNoCC.mkDerivation rec {
  pname = "sddm-astronaut";
  version = "1.0-unstable-2026-02-23";

  src = pkgs.fetchFromGitHub {
    owner = "ArcticOwl-Dev";
    repo = "sddm-astronaut-theme";
    rev = "8e2c12843931ea9c9818750e295a4404a56f959f";
    hash = "sha256-r3yWRante+SOo9tCSLI7ewNXI2u2zU26eqCttUZHEJM=";
  };

  dontWrapQtApps = true;

  propagatedBuildInputs = with pkgs.kdePackages; [
    qtsvg
    qtmultimedia
    qtvirtualkeyboard
  ];

  installPhase =
    let
      iniFormat = pkgs.formats.ini { };
      configFile = iniFormat.generate "" { General = themeConfig; };

      basePath = "$out/share/sddm/themes/sddm-astronaut-theme";
      sedString = "ConfigFile=Themes/";
    in
    ''
      mkdir -p ${basePath}
      cp -r $src/* ${basePath}
    ''
    + lib.optionalString (embeddedTheme != "astronaut") ''

      # Replaces astronaut.conf with embedded theme in metadata.desktop on line 9.
      # ConfigFile=Themes/astronaut.conf.
      sed -i "s|^${sedString}.*\\.conf$|${sedString}${embeddedTheme}.conf|" ${basePath}/metadata.desktop
    ''
    + lib.optionalString (themeConfig != null) ''
      chmod u+w ${basePath}/Themes/
      cp ${configFile} ${basePath}/Themes/${embeddedTheme}.conf.user
    '';

  meta = {
    description = "Modern looking qt6 sddm theme (ArcticOwl-Dev fork)";
    homepage = "https://github.com/ArcticOwl-Dev/sddm-astronaut-theme";
    license = lib.licenses.gpl3;

    platforms = lib.platforms.linux;
    maintainers = [ ];
  };

  # NixOS module: sets ThemeDir to the theme store path so SDDM loads it directly.
  passthru.nixosModule = ./nixos-module.nix;
}
