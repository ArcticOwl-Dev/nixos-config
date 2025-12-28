{ lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "plymouth-theme-cuts";
  version = "2023-08-22";

  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "plymouth-themes";
    rev = "master";
    # Note: On first build, Nix will error with the correct hash.
    # Replace this placeholder with the hash Nix provides.
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  # Only extract the cuts theme directory
  sourceRoot = "source/pack_1/cuts";

  installPhase = ''
    mkdir -p $out/share/plymouth/themes/cuts
    cp -r * $out/share/plymouth/themes/cuts/
  '';

  meta = with lib; {
    description = "Cuts plymouth theme from adi1090x/plymouth-themes";
    homepage = "https://github.com/adi1090x/plymouth-themes";
    license = licenses.gpl3Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

