{ config, lib, pkgs, ... }:
let
  # Scripts module - every file in home/scripts/ becomes an executable in ~/.local/bin 
  # (same name, .sh stripped)
  
  scriptsDir = ".local/bin";
  scriptFiles = lib.filterAttrs
    (name: type: type == "regular" && lib.hasSuffix ".sh" name && name != "default.nix")
    (builtins.readDir ./.);
  scriptNames = builtins.attrNames scriptFiles;
  # Install as "nix-update" for "nix-update.sh"
  toBinEntry = name: {
    name = "${scriptsDir}/${lib.removeSuffix ".sh" name}";
    value = {
      source = ./. + "/${name}";
      executable = true;
    };
  };
in
{
  home.sessionVariables = {
    PATH = "$HOME/${scriptsDir}:$PATH";
  };

  home.file = lib.listToAttrs (map toBinEntry scriptNames);
}
