## Best try to get dolphin in dark, but stylesheet does not style properly
## TODO: Find a better way to get dolphin in dark


{config, lib, pkgs, ...}:
let
  # Read the Breeze Dark stylesheet from the same directory
  breezeDarkStylesheet = pkgs.writeText "breeze-dark.qss" 
    (builtins.readFile ./BreezeStyleSheet-dark.qss);
  
  # Create a wrapped Dolphin with dark stylesheet
  dolphin-dark = pkgs.symlinkJoin {
    name = "dolphin-dark";
    paths = [ pkgs.kdePackages.dolphin ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/dolphin \
        --add-flags "-stylesheet ${breezeDarkStylesheet}" \
        --prefix XDG_DATA_DIRS : "${pkgs.kdePackages.breeze-icons}/share"
    '';
  };
in
{
  home.packages = with pkgs; [ 
    dolphin-dark                    # Wrapped Dolphin with dark theme
    kdePackages.qtsvg               # for svg support
    kdePackages.kio               
    kdePackages.kio-extras          # extra protocols support (sftp, fish and more)     
    kdePackages.kio-fuse            # to mount remote filesystems via FUSE
    kdePackages.breeze-icons        # Breeze icon theme
  ];
}


