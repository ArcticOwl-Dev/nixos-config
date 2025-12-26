{ lib
, stdenv
, fetchurl
, makeWrapper
, writeShellScriptBin
}:

stdenv.mkDerivation rec {
  pname = "unified-remote";
  version = "3.14.0.2574";

  src = fetchurl {
    url = "https://www.unifiedremote.com/static/builds/server/linux-x64/2574/urserver-${version}.tar.gz";
    hash = "sha256-4wA2VPb5QN30TWa72pUVTYfvsxlGTO8Vngh7wDHXhDE=";
  };

  nativeBuildInputs = [ makeWrapper ];

  # The archive contains a top-level directory, so we need to strip it
  sourceRoot = "urserver-${version}";

  installPhase = ''
    mkdir -p $out/opt/urserver
    cp -r . $out/opt/urserver/
    chmod +x $out/opt/urserver/urserver

    # Create bin directory and wrapper scripts
    mkdir -p $out/bin

    # Start script
    cat > $out/bin/urserver-start <<EOF
    #!${stdenv.shell}
    cd $out/opt/urserver
    exec ./urserver --daemon
    EOF
    chmod +x $out/bin/urserver-start

    # Stop script
    cat > $out/bin/urserver-stop <<EOF
    #!${stdenv.shell}
    pkill -f "urserver.*--daemon" || true
    EOF
    chmod +x $out/bin/urserver-stop

    # Also create a direct symlink to urserver
    ln -s $out/opt/urserver/urserver $out/bin/urserver
  '';

  meta = with lib; {
    description = "Unified Remote Server - Control your computer from your phone";
    homepage = "https://www.unifiedremote.com/";
    license = licenses.unfree; # Commercial software
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
  };
}

