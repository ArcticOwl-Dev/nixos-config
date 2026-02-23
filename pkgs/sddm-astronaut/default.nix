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
    rev = "c66df3084f1a2bb70bd76f6c64f2d24e57d169ab";
    hash = "sha256-0fTOjlWlnszuhErEsGBE6n0+vokI7fYPn8R2w47ZnXo=";
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
      ln -sf ${configFile} ${basePath}/Themes/${embeddedTheme}.conf.user
    '';

  meta = {
    description = "Modern looking qt6 sddm theme (ArcticOwl-Dev fork)";
    homepage = "https://github.com/ArcticOwl-Dev/sddm-astronaut-theme";
    license = lib.licenses.gpl3;

    platforms = lib.platforms.linux;
    maintainers = [ ];
  };
}
