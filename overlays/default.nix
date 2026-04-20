# This file defines overlays
{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final inputs;

  # Apply patches to nixpkgs packages (see readme.md).
  modifications = final: prev: {
    # Use your fork of sddm-astronaut-theme; same install as nixpkgs (no patches).
    sddm-astronaut = prev.sddm-astronaut.overrideAttrs (old: {
      src = prev.fetchFromGitHub {
        owner = "ArcticOwl-Dev";
        repo = "sddm-astronaut-theme";
        rev = "c66df3084f1a2bb70bd76f6c64f2d24e57d169ab";
        hash = "sha256-0fTOjlWlnszuhErEsGBE6n0+vokI7fYPn8R2w47ZnXo=";
      };
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
