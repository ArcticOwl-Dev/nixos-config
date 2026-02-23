{config, lib, pkgs, ...}:
let
  # Override ulauncher to use GitHub release v6.0 beta
  ulauncher-beta = pkgs.ulauncher.overrideAttrs (oldAttrs: rec {
    version = "6.0.0-beta27";

    src = pkgs.fetchFromGitHub {
      owner = "Ulauncher";
      repo = "Ulauncher";
      rev = "v${version}";
      hash = "sha256-xOd/2T6vb6PQjcLEMVK4L3cSH/uSARfAAPEcZ+qSm4w=";
      fetchSubmodules = true;
    };

    # Disable patches as they don't apply to v6.0 beta
    patches = [];
    
    # Override postPatch to skip wmctrl substitution but keep other logic
    postPatch = ''
      # Skip wmctrl substitution for v6.0 beta
      # The original postPatch tries to substitute wmctrl which doesn't exist in v6.0
      # Other postPatch logic from oldAttrs is preserved if needed
    '';
    
    # Add setuptools-scm as build dependency (required for v6.0)
    nativeBuildInputs = (oldAttrs.nativeBuildInputs or []) ++ [
      pkgs.python3Packages.setuptools-scm
      pkgs.makeWrapper
    ];
    
    # Add missing runtime dependencies for v6.0
    propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or []) ++ [
      pkgs.python3Packages.xlib
    ];
    
    # Fix assets path for v6.0 beta - set ULAUNCHER_SYSTEM_DATA_DIR to point to package share
    postInstall = ''
      wrapProgram $out/bin/ulauncher \
        --set ULAUNCHER_SYSTEM_DATA_DIR "$out/share/ulauncher"
      wrapProgram $out/bin/ulauncher-toggle \
        --set ULAUNCHER_SYSTEM_DATA_DIR "$out/share/ulauncher"
    '';
  });
in
{
  home.packages = with pkgs; [
    ulauncher
  ];
}