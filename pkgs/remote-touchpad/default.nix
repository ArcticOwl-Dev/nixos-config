{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "remote-touchpad";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "unrud";
    repo = "remote-touchpad";
    rev = "v${version}";
    hash = "sha256-dSBkRBT3crdoO3JB3kVSUDC0faRrxa/R5MF/3a9POxo=";
  };

  # Build tags for Wayland portal and uinput support
  # portal: Wayland support via RemoteDesktop portal
  # uinput: Linux input device support
  tags = [ "portal" "uinput" ];

  vendorHash = "sha256-B/nxV9iHebe3v7VM+TTFGnAnPcBICtW+rDyrNNY6Ixw=";

  meta = with lib; {
    description = "Control mouse and keyboard from a smartphone or tablet";
    homepage = "https://github.com/unrud/remote-touchpad";
    license = licenses.gpl3Only;
    maintainers = [ ];
    platforms = platforms.linux;
  };
}

