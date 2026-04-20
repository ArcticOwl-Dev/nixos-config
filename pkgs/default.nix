# Custom packages under pkgs.local.* so they don't override nixpkgs names.
# Use e.g. pkgs.local.sddm-astronaut; build with 'nix build .#packages.x86_64-linux.local.sddm-astronaut'
pkgs: inputs: {
  local = {
    remote-touchpad = pkgs.callPackage ./remote-touchpad {
      src = inputs.remote-touchpad;
    };
    plymouth-theme-cuts = pkgs.callPackage ./plymouth-theme-cuts { };
    sddm-astronaut = pkgs.callPackage ./sddm-astronaut { };
  };
}
